<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\Compte;
use App\Models\Produit;
use App\Models\Commande;
use App\Traits\Paydunya;
use App\Models\Versement;
use App\Models\Commercant;
use PHPUnit\TextUI\Command;
use PHPUnit\Util\Exception;
use App\Models\EtatCommande;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\URL;
use App\Http\Controllers\Controller;
use Paydunya\Checkout\CheckoutInvoice;
use App\Http\Controllers\NotificationController;
use App\Models\ModePayement;
use App\Traits\Notification;

class CommercantController extends Controller
{
    use Utils, Paydunya, Notification;
    public function profile()
    {
        return $this->authCommercant();
    }

    public function dashboard()
    {
        return $this->commercantDashBoard();
    }

    public function ventes()
    {
        return $this->commercantVentes();
    }

    public function solde()
    {
        return $this->soldeCommercant();
    }

    public function retrait(Request $request)
    {
        $this->validate($request, [
            "montant" => "required",
            "telephone" => "required"
        ]);

        return $this->doRetrait($request->telephone, $request->number);
    }


    /**
     * Aujouter une commande pour un client
     *
     * @param Request $request
     */
    public function createCommande(Request $request)
    {

        $this->validate($request, [
            "produits" => "required|array",
            "client_id" => "required|exists:clients,id",
            "mode_paiement" => "required|exists:mode_payement,id",
            "first_part" => "required",
            "type" => "required|boolean"
        ]);

        $client = Client::find($request->client_id);
        $user = User::whereModel($client->id)->first();
        $commercant = $this->authCommercantWithBoutique();
        $mode = ModePayement::find($request->mode_paiement);

        $check = $this->isPossibleForClient($request, $client, $user, $commercant);
        if ($check["error"] == true) {
            if ($check["sms"])
                $this->sendSMS($check['sms'], '+221' . $client->telephone);
            return response()->json([
                "message" => $check['message']
            ], Response::HTTP_CONFLICT);
        }
        $prix_total = $check["prix_total"];

        $commande = new Commande;
        $commande->reference = now()->timestamp;
        $commande->nb_produits = count($request->produits);
        $commande->nb_tranche = $mode->nb_mois;
        $commande->date_time = now();
        $commande->date_limite = now()->addMonth($mode->nb_mois);
        $commande->boutique_id = $commercant->boutique->id;
        $commande->client_id = $request->client_id;
        $commande->etat_commande_id = EtatCommande::whereNom("append")->first()->id;
        $commande->interet = $mode->interet;
        $commande->client_id = $request->client_id;
        $commande->prix_total = $prix_total;
        $commande->commission = $prix_total * $mode->interet;
        $commande->save();

        foreach ($request->produits as $value) {
            $p = new Produit;
            $p->nom = $value['nom'];
            $p->quantite = $value['quantite'];
            $p->commande_id = $commande->id;
            $p->prix_unitaire = $value['prix_unitaire'];
            $p->save();
        }

        /**
         * Proceder au paiement du premier tranche
         */
        if ($request->type == false) {
            $response = $this->paiementEnLigne($request, $commande, $client);
            if (!$response['error']) {
                $this->sendSMS($response['sms'], '+221' . $client->telephone);
            }
            return response()->json([
                "message" => $response['message']
            ], $response['code']);
        }
        else {
            $response = $this->paiementEnCaise($request, $commande, $client);
            $this->sendSMS($response['sms'], '+221' . $client->telephone);
            return response()->json([
                "message" => $response['message']
            ], $response['code']);
        }
    }


    public function fpIPN(Request $request)
    {
        try {
            //Prenez votre MasterKey, hashez la et comparez le résultat au hash reçu par IPN
            if ($request->data['hash'] === hash('sha512', env("PAYDUNYA_MASTER_KEY"))) {
                if ($request->data['status'] == "completed") {
                    DB::beginTransaction();

                    $invoice = $request->data['invoice'];
                    $amount = $invoice["total_amount"];
                    $token = $invoice["token"];

                    $customData = $request->data["custom_data"];

                    $commande = Commande::find($customData["commande_id"]);
                    $commande->etat_commande_id = EtatCommande::whereNom("load")->first()->id;
                    $commande->save();

                    $compte = Compte::find($customData["compte_id"]);
                    $compte->solde += $commande->prix_total;
                    $compte->save();

                    $versement = new Versement;
                    $versement->date_time = now();
                    $versement->via = 'Paiement en Ligne';
                    $versement->reference = $token;
                    $versement->montant = $amount;
                    $versement->commande_id = $commande->id;
                    // facture pour une autre version;
                    //echo $invoice->getReceiptUrl(); facture PDF
                    $versement->save();

                    $client = Client::find($customData["client_id"]);
                    $message = "Bonjour " . $client->prenoms . "\nVotre commande est maintenant en cours. Vous avez payé la première trachepay. Retrouvez tous les détails sur https://tranchepay.com\n\nTRANCHEPAY, merci pour votre confiance.";
                    $this->sendSMS($message, '+221' . $client->telephone);


                    DB::commit();
                    return response()->json([], 200);
                }

            }
            else {
                die("Cette requête n'a pas été émise par PayDunya");
            }
        }
        catch (Exception $e) {
            throw $e;
        }
    }
}
