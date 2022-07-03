<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Mail\SendClientHelpMail;
use Illuminate\Http\Request;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\User;
use App\Traits\Paydunya;
use PHPUnit\TextUI\Exception;
use Paydunya\Checkout\CheckoutInvoice;
use App\Models\Commande;
use App\Models\Boutique;
use App\Models\Versement;
use App\Models\EtatCommande;
use App\Models\Compte;
use Illuminate\Support\Facades\Mail;
use App\Mail\SendHelpMail;
use App\Models\Padding;
use App\Traits\Notification;

class ClientController extends Controller
{
    use Utils;
    use Paydunya;
    use Notification;


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
        return Commande::whereClientId($this->authClient()->id)
            ->where("etat_commande_id", "!=", EtatCommande::whereNom("append")->first()->id)
            ->get();
    }

    public function versementsClient()
    {
        $commandes = Commande::whereClientId($this->authClient()->id)->get()->pluck('id');
        return Versement::with("commande")->whereIn('commande_id', $commandes)->get();
    }

    public function search($data)
    {
        return Client::where("telephone", 'like', '%' . $data . '%')->get();
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
            "cancel_url" => "required",
            "return_url" => "required"
        ]);

        $commande = Commande::with(["produits", "versements", "boutique"])
            ->whereClientId($this->authClient()->id)
            ->whereId($request->commande_id)
            ->first();

        if ($commande) {
            $restant = $this->restant($commande);
            if ($restant < $request->montant) {
                return response()->json([
                    "message" => "Il vous reste que $restant FCFA à payer. Merci d'effectuer un versement correcte."
                ], 422);
            }

            $this->initPayement();
            $this->setReturnUrl($request->return_url);
            $this->setCancelUrl($request->cancel_url);
            $invoice = new CheckoutInvoice();

            foreach ($commande->produits as $value) {
                $invoice->addItem($value->nom, $value->quantite, $value->prix_unitaire, $value->quantite * $value->prix_unitaire);
            }
            $invoice->setDescription("Nouveau versement pour la commande #" . $commande->reference);
            $invoice->setTotalAmount($request->montant);

            // set custom data
            $client = $this->authClient();
            $invoice->addCustomData('client_phone', $client->telephone);
            $invoice->addCustomData('client_id', $client->id);
            $invoice->addCustomData('boutique_id', $commande->boutique->id);
            $invoice->addCustomData('commande_id', $commande->id);


            if ($invoice->create()) {
                return response()->json($invoice->getInvoiceUrl(), 200);
            } else {
                return response()->json($invoice->response_text, 400);
            }
        } else {
            return response()->json([
                "message" => "Commande introuvable",
            ], 404);
        }
    }

    public function clientCancelURL()
    {
    }

    public function clientReturnURL($token)
    {
        $invoice = new CheckoutInvoice();
        if ($invoice->confirm($token)) {

            if ($invoice->getStatus() === "completed") {
                $commande = Commande::find($invoice->getCustomData("commande_id"));
                $amount = $invoice->getTotalAmount();
                $versement = new Versement;
                $versement->date_time = now();
                $versement->via = 'INCONNUE';
                $versement->reference = $token;
                $versement->montant = $amount;
                $versement->commande_id = $commande->id;
                // facture pour une autre version;
                //echo $invoice->getReceiptUrl(); facture PDF
                $versement->save();
                return response()->json([], 200);
            }
            return response()->json();
        } else {
            return response()->json([
                $invoice->getStatus(),
                $invoice->response_text,
                $invoice->response_code
            ], 422);
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
