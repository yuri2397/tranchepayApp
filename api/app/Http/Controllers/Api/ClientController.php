<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\Compte;
use App\Models\Padding;
use App\Models\Boutique;
use App\Models\Commande;
use App\Traits\Paydunya;
use App\Models\Versement;
use App\Mail\SendHelpMail;
use App\Models\EtatCommande;
use App\Traits\FreePayement;
use App\Traits\Notification;
use App\Traits\WavePayement;
use Illuminate\Http\Request;
use PHPUnit\TextUI\Exception;
use App\Mail\SendClientHelpMail;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Mail;
use Paydunya\Checkout\CheckoutInvoice;

class ClientController extends Controller
{
    use Utils;
    use Paydunya;
    use Notification, WavePayement, FreePayement;


    public function profile()
    {
        return $this->authClient();
    }

    /**
     * Listes des commandes d'un client
     *
     * @return void
     */
    public function commandes()
    {
        $append = EtatCommande::whereNom("append")->first();
        $commandes =  Commande::whereClientId($this->authClient()->id)
            ->where("etat_commande_id", "!=", $append->id)
            ->orderBy('created_at', 'DESC')
            ->get();

        return $commandes;
    }

    public function versementsClient()
    {
        $commandes = Commande::whereClientId($this->authClient()->id)->get()->pluck('id');
        return Versement::with("commande")->whereIn('commande_id', $commandes)->get();
    }

    public function search(Request $request)
    {
        return Client::where("telephone", 'like', '%' . $request->data . '%')
            ->get();
    }

    public function create(Request $request)
    {
        $this->validate($request, [
            'prenoms' => 'required|string',
            'nom' => 'required|string',
            'telephone' => 'required|unique:users,username',
            'password' => 'required'
        ]);

        $client = new Client;
        $client->prenoms = $request->prenoms;
        $client->nom = $request->nom;
        $client->telephone = $request->telephone;
        $client->save();

        $user = new User;
        $user->username = $client->telephone;
        $user->password = bcrypt($request->password == -1 ? '0000' : $request->password);
        $user->model = $client->id;
        $user->model_type = "Client";
        $user->save();

        $message = "Votre est crée avec succès.";
        $this->sendSMS($message, $client->telephone);

        return response()->json($client, 201);
    }

    public function clientIPN(Request $request)
    {
        try {
            //Prenez votre MasterKey, hashez la et comparez le résultat au hash reçu par IPN
            if ($request->data['hash'] === hash('sha512', env("PAYDUNYA_MASTER_KEY"))) {

                if ($request->data['status'] == "completed") {
                    $invoice = $request->data['invoice'];
                    $amount = $invoice["total_amount"];
                    $token = $invoice["token"];

                    $customData = $request->data["custom_data"];
                    $commande = Commande::with("versements")->find($customData["commande_id"]);

                    $versement = new Versement;
                    $versement->date_time = now();
                    $versement->via = 'PAIEMENT EN LIGNE';
                    $versement->reference = $token;
                    $versement->montant = $amount;
                    $versement->commande_id = $commande->id;
                    // facture pour une autre version;
                    //echo $invoice->getReceiptUrl(); facture PDF
                    $versement->save();
                    $res = $this->restant($commande);
                    if ($res == 0) {
                        $commande->etat_commande_id = EtatCommande::whereNom("finish")->first()->id;
                        $commande->save();
                    }
                    return response()->json([], 200);
                }
            } else {
                die("Cette requête n'a pas été émise par PayDunya");
            }
        } catch (Exception $e) {
            die();
        }
    }

    public function confirmePayement(Request $request)
    {

        $request->validate([
            "padding" => "required|exists:paddings,reference",
            "commande" => "required|exists:commandes,id"
        ]);

        $commande = Commande::find($request->id);
        $padding = Padding::whereReference($request->padding)->first();
        $user = $this->authClient();
        return $this->confirmeClientPayement($padding, $user, $commande, $request->condePin);
    }

    public function effectuerVersement(Request $request)
    {
        $this->validate($request, [
            "commande_id" => "required|exists:commandes,id",
            "montant" => "required|numeric",
            "via" => "string|required"
        ]);

        $commande = Commande::with(["produits", "versements", "boutique"])
            ->whereClientId($this->authClient()->id)
            ->whereId($request->commande_id)
            ->first();

        $client = $this->authClient();
        $telephone = $request->telephone;
        if (!$telephone) {
            $telephone = $client->telephone;
        }

        if ($commande) {
            $restant = $this->restant($commande);
            if ($restant < $request->montant) {
                return response()->json([
                    "message" => "Il vous reste que $restant FCFA à payer. Merci d'effectuer un versement correcte."
                ], 422);
            }
            switch ($request->via) {
                case 'om':
                    if (!$this->isValideOrangeNumber($telephone)) {
                        return response()->json([
                            "message" => "Pour payer avec Orange Money, veuillez mettre un numéro orange valide."
                        ], 422);
                    }
                    $om = $this->requestOMPayement($request->montant, $telephone, $client, $commande, "vm");

                    if ($om['response']['status'] === 'INITIATED') {
                        return response()->json([
                            "padding" => $om["padding"],
                            "code" => 201,
                            "message" => "Votre verssement est en attente de confirmation.",
                            "data" => $om['response']
                        ]);
                    } else if ($om['response']['status'] >= 400 && $om['response']['status'] < 500) {
                        return response()->json([
                            "message" => $om['response']["detail"],
                            "om" => $om
                        ], 422);
                    }
                    break;
                case 'wave':
                    $response  = $this->createCheckoutSession($request->montant, $client, $commande, "vm");
                    if ($response && $response['response']['id']) {
                        return response()->json([
                            "padding" => $response["padding"],
                            "code" => 201,
                            "message" => "Votre verssement est en attente de confirmation.",
                            "data" => $response['response']
                        ]);
                    }
                    return response()->json([
                        "message" => "Une erreur est survenu lors que votre opération. Merci de reessayer plus tard."
                    ], 503);
                    break;
                case 'free':
                    if (!$this->isValideFreeNumber($telephone)) {
                        return response()->json([
                            "message" => "Pour payer avec FreeMoney, veuillez mettre un numéro free."
                        ], 422);
                    }

                    $response = $this->requestFreePayement($request->montant, $telephone, $client, $commande, 'vm');
                    if ($response && $response['response']['status'] == 'PENDING') {
                        return response()->json([
                            "padding" => $response["padding"],
                            "message" => "Votre verssement est en attente de confirmation.",
                            "data" => json_decode($response['response'])
                        ]);
                    }
                    return response()->json([
                        "message" => "Une erreur est survenu lors que votre opération. Merci de reessayer plus tard."
                    ], 503);
                    break;
            }
        } else {
            return response()->json([
                "message" => "Commande introuvable",
            ], 404);
        }
    }

    public function contactUs(Request $request)
    {
        $request->validate([
            "type" => "required|string",
            "full_name" => "required|string",
            "email" => "required|email",
            "message" => "required|string"
        ]);

        if ($request->type === "client")
            return Mail::to(env('SERVICE_CLIENT_MAIL'))->send(new SendClientHelpMail($request->email, $request->full_name, $request->message, $request->telephone, $request->site, $request->entreprise));
        return Mail::to(env('SERVICE_COMMERCANT_MAIL'))->send(new SendHelpMail($request->email, $request->full_name, $request->message, $request->telephone, $request->site, $request->entreprise));
    }


    public function deplafonner(Request $request)
    {
        $request->validate([
            "cni" => "required|numeric",
        ]);
    }

    public function paddings()
    {
        return Padding::whereUserId($this->authClient()->id)->limit(5)->get();
    }

    public function confirmePaddings(Request $request, Padding $padding)
    {
        return "ok";
    }
}
