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
use PHPUnit\Util\Exception;
use App\Models\EtatCommande;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Models\BoutiqueHasUser;
use App\Models\ModePayement;
use App\Traits\Notification;

class CommercantController extends Controller
{
    use Utils, Paydunya;
    public function profile()
    {
        return $this->authCommercant();
    }

    public function dashboard()
    {
        return $this->commercantDashBoard();
    }

    public function ventes(Request $request)
    {
        return $this->commercantVentes($request);
    }

    public function solde()
    {
        return $this->soldeCommercant();
    }

    public function retrait(Request $request)
    {
        $this->validate($request, [
            "montant" => "required",
            "telephone" => "required",
            "via" => "required"
        ]);

        return $this->doRetrait($request->telephone, $request->number, $request->via);
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
            "type" => "required|string"
        ]);

        try {
            DB::beginTransaction();

            $client = Client::with("commandes")->find($request->client_id);
            $user = User::whereModel($client->id)->first();
            $commercant = $this->authCommercantWithBoutique();
            $mode = ModePayement::find($request->mode_paiement);

            $check = $this->isPossibleForClient($request, $client, $user, $commercant);
            if ($check["error"] == true) {
                if (array_key_exists("sms", $check))
                    $this->sendSMS($check['sms'], '+221' . $client->telephone);
                return response()->json([
                    "message" => $check['message']
                ], Response::HTTP_CONFLICT);
            }
            $prix_total = $check["prix_total"];

            $commande = new Commande;
            $commande->reference = uniqid();
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
            $commande->commission = $prix_total * ($mode->interet / 100);
            $commande->save();

            foreach ($request->produits as $value) {
                $p = new Produit;
                $p->nom = $value['nom'];
                $p->quantite = $value['quantite'];
                $p->commande_id = $commande->id;
                $p->prix_unitaire = $value['prix_unitaire'];
                $p->save();
            }

            $telephone = $request->telephone;
            if (!$telephone) {
                $telephone = $client->telephone;
            }

            /**
             * Proceder au paiement du premier tranche
             */
            if ($request->type == 'online') {
                $response = $this->paiementEnLigne($request, $commande, $client, $telephone);
                DB::commit();
                return $response;
            } else if ($request->type === 'offline') {
                $response = $this->paiementEnCaise($request, $commande, $client);
                $this->sendSMS($response['sms'], '+221' . $client->telephone);
                DB::commit();
                return response()->json([
                    "message" => $response['message'],
                ], $response['code']);
            } else {
                DB::rollBack();
                return response()->json([
                    "message" => "Une erreur s'est produite. Merci de reessayer plus tard."
                ], 409);
            }
        } catch (\Throwable $th) {
            DB::rollBack();
            return response()->json([
                "message" => "Une erreur s'est produite, merci de contacter le service client.",
                "error" => $th->getMessage()
            ], 503);
        }
    }


    public function users()
    {
        $users = BoutiqueHasUser::whereBoutiqueId($this->authCommercant()->boutique->id)->get();

        $commercants = User::find(array_map(function ($e) {
            return $e['user_id'];
        }, $users->toArray()));

        return  Commercant::find(array_map(function ($e) {
            if ($e['model_type'] == "Commercant") {
                return $e['model'];
            }
            return -1;
        }, $commercants->toArray()));
    }
}
