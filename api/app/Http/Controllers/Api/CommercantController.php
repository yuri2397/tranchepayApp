<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\Compte;
use App\Models\Produit;
use App\Models\Boutique;
use App\Models\Commande;
use App\Traits\Paydunya;
use App\Models\Versement;
use App\Models\Commercant;
use PHPUnit\Util\Exception;
use App\Models\EtatCommande;
use App\Models\ModePayement;
use App\Traits\Notification;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\BoutiqueHasUser;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;

class CommercantController extends Controller
{
    use Utils, Paydunya;

    public function __construct()
    {
        $this->middleware('auth:api')->except(['index', 'store', 'show']);
    }

    public function index(Request $request)
    {
        $commercants = Commercant::with($request->with ?? []);

        if ($request->has('q')) {
            $commercants->where('prenoms', 'like', "%{$request->q}%")
                ->orWhere('nom', 'like', "%{$request->q}%")
                ->orWhere('telephone', 'like', "%{$request->q}%");
        }

        if ($request->has('per_page')) {
            return $commercants->paginate($request->per_page ?? 15, $request->columns ?? ['*'], $request->page_name ?? 'page', $request->current_page ?? 1);
        }

        return $commercants->get();
    }


    public function show(Request $request, $id)
    {
        return Commercant::with($request->with ?? [])->find($id);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            "nom" => "required",
            "prenoms" => "required",
            "email" => "string",
            "telephone" => "required|unique:commercants,telephone",
            "adresse" => "string",
            "password" => "required",
        ]);

        try {
            $commercant = new Commercant();
            $commercant->nom = $request->nom;
            $commercant->prenoms = $request->prenoms;
            $commercant->telephone = formatOnePhone($request->telephone, false);
            $commercant->adresse = $request->adresse;
            $commercant->save();

            $user = new User();
            $user->email = $request->email;
            $user->username = formatOnePhone($request->telephone, false);
            $user->password = bcrypt($request->password);
            $user->model_type = Commercant::class;
            $user->model = $commercant->id;
            $user->save();

            // $boutique = new Boutique();
            // $boutique->nom = $request->boutique["nom"];
            // $boutique->addresse = $request->boutique["addresse"];
            // $boutique->telephone = formatOnePhone($request->boutique["telephone"], false);
            // $boutique->commercant_id = $commercant->id;
            // $boutique->save();

            // $compte = new Compte();
            // $compte->solde = 0;
            // $compte->boutique_id = $boutique->id;
            // $compte->save();

            return response()->json([
                "message" => "Commercant enregistré avec succès",
                "commercant" => $commercant
            ], Response::HTTP_CREATED);
        } catch (\Throwable $th) {

            return response()->json([
                "message" => "Une erreur est survenue",
                "error" => $th->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function update(Request $request, $id)
    {
        $this->validate($request, [
            "nom" => "required",
            "prenoms" => "required",
            "telephone" => "required|unique:commercants,telephone," . $id,
            "adresse" => "string",
            "boutique.*.nom" => "required",
            "boutique.*.addresse" => "required",
        ]);

        try {
            $commercant = Commercant::find($id);
            $commercant->nom = $request->nom;
            $commercant->prenoms = $request->prenoms;
            $commercant->telephone = $request->telephone;
            $commercant->adresse = $request->adresse;
            $commercant->save();

            $boutique = Boutique::whereCommercantId($commercant->id)->first();
            $boutique->nom = $request->boutique["nom"];
            $boutique->addresse = $request->boutique["addresse"];
            $boutique->commercant_id = $commercant->id;
            $boutique->save();

            return response()->json([
                "message" => "Commercant enregistré avec succès",
                "commercant" => $commercant
            ], Response::HTTP_CREATED);
        } catch (\Throwable $th) {

            return response()->json([
                "message" => "Une erreur est survenue",
                "error" => $th->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function destroy($id)
    {
        try {
            $commercant = Commercant::find($id);
            $commercant->delete();

            return response()->json([
                "message" => "Commercant supprimé avec succès",
                "commercant" => $commercant
            ], Response::HTTP_OK);
        } catch (\Throwable $th) {

            return response()->json([
                "message" => "Une erreur est survenue",
                "error" => $th->getMessage()
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

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

            $telephone = formatOnePhone($request->telephone);
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
                $this->sendSMS($response['sms'], $client->telephone);
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
