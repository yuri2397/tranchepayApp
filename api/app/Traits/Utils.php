<?php

namespace App\Traits;

use App\Models\User;
use App\Models\Param;
use App\Models\Client;
use App\Models\Compte;
use App\Models\Boutique;
use App\Models\BoutiqueHasUser;
use App\Models\Commande;
use App\Models\Versement;
use App\Models\Commercant;
use App\Models\EtatCommande;
use App\Models\Padding;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\URL;
use Paydunya\Checkout\CheckoutInvoice;

trait Utils
{
    use Paydunya, OMPayement, WavePayement, FreePayement, Notification;

    protected $commercant_session_key = 'commercant';
    protected $client_session_ket = 'client';
    protected $interet = [
        "1" => 0.05,
        "2" => 0.07,
        "3" => 0.1
    ];

    public function getUserInfo(User $user)
    {
        if ($user->model_type == "Commercant" && $user->hasPermission('administrateur')) {
            return Commercant::with("boutique")->find($user->model);
        } else if ($user->model_type == "Commercant") {
            $commercant = Commercant::find($user->model);
            $commercant->boutique = BoutiqueHasUser::whereUserId($commercant->model)->first()->boutique;
            return $commercant;
        }
        return Client::with("commandes")->find($user->model);
    }

    public function currentUser(): User
    {
        return User::find(auth()->id());
    }

    public function authCommercantWithBoutique()
    {
        return Commercant::with("boutique")->find($this->currentUser()->model);
    }

    public function isCommercant(User $user)
    {
        if ($user->model_type == "Commercant") {
            return true;
        }
        return false;
    }

    public function parsePhone($phone)
    {
    }

    public function paiementEnCaise(Request $request, Commande $commande, Client $client)
    {
        $commande->etat_commande_id = EtatCommande::whereNom("load")->first()->id;
        $commande->save();

        $versement = new Versement;
        $versement->date_time = now();
        $versement->via = 'PAIEMENT EN CAISE';
        $versement->reference = $commande->reference;
        $versement->montant = $request->first_part;
        $versement->commande_id = $commande->id;
        $versement->save();

        $compte = Compte::find(Boutique::find($commande->boutique_id)->compte->id);
        $compte->solde += $this->totalCommande($request->produits);
        $compte->save();

        $message = "Salut " . $client->prenoms . "\nVotre commande de  " . ($commande->prix_total - $commande->commission) . " FCFA chez " . $this->authCommercantWithBoutique()->boutique->nom . " est valid??.Vous paierez une commission de " . $commande->commission . " FCFA.\nRetrouver nous sur https://tranchepay.com pour plus de d??tails.";
        return [
            "error" => false,
            "code" => 201,
            "sms" => $message,
            "message" => "La commande est bien enregistr??e."
        ];
    }

    /**
     * Faire un paiement en ligne pour client.
     *
     * @param Request $request
     * @param Commande $commande
     * @param Client $client
     * @return mixed
     */
    public function paiementEnLigne(Request $request, Commande $commande, Client $client)
    {
        switch ($request->via) {
            case 'free':
                $free = $this->requestFreePayement($request->first_part,  $client, $commande, "fp");
                if (array_key_exists('status', json_decode($free['response'], true)) && $free['response']['status'] == 'PENDING') {
                    $sms = "Votre commande chez " . $commande->boutique->name . " est en attente. Merci de payer les " . $request->first_part . "FCFA via Free Money.\nTranche Pay";
                    $this->sendSMS($sms, '+221' . $client->telephone);
                    return [
                        "error" => false,
                        "code" => 201,
                        "padding" => $free['padding'],
                        "message" => "La commande est attends de paiement merci d'attendre la validation du client."
                    ];
                }
                break;

            case 'wave':
                $response = $this->createCheckoutSession($request->first_part, $client, $commande, "fp");
                if (array_key_exists('id', json_decode($response['response'], true))) {
                    // $sms = "Votre commande chez " . $commande->boutique->name . " est en attente. Merci de payer les " . $request->first_part . "FCFA via wave." . $response['wave_launch_url'] . "\nTranche Pay";
                    // $this->sendSMS($sms, '+221' . $client->telephone);
                    return [
                        "error" => false,
                        "code" => 201,
                        "padding" => $response['padding'],
                        "message" => "La commande est attends de paiement merci d'attendre la validation du client."
                    ];
                }
                break;
        }

        $commande->delete();
        return [
            "error" => true,
            "code" => 400,
            "message" => "Le payement est annul??e de meme que la commande. Merci de r??essayer plus tard."
        ];
    }


    /**
     * V??rifier si le client a le droit d'??ffectuer cette commande.
     * En v??rifiant si son compte est active, mais aussi si il n'a de commandes encours.
     *
     * @param Client $client
     * @param User $user
     * @param Commercant $commercant
     * @return mixed
     */
    public function isPossibleForClient(Request $request, Client $client, User $user, Commercant $commercant)
    {
        //SI LE COMPTE CLIENT EST ACTIV??
        if ($user->email_verify_at == null) {
            $message = "Bonjour " . $client->prenoms . "\nVotre commande chez " . $commercant->boutique->nom . " est annul?? car votre compte tranchePay n'est pas active. Merci de l'activer en utiliser le lien sur le SMS d'inscription.\n\nTRANCHEPAY";

            return [
                "error" => true,
                "sms" => $message,
                "message" => "Le compte de ce client n'est pas activ??."
            ];
        }

        // VERIFIER SI LE CLIENT A LA POSSIBILITE DE FAIRE CETTE COMMANDE
        $commandes = Commande::where(function ($query) {
            $query->where('etat_commande_id', '=', EtatCommande::whereNom("append")->first()->id)
                ->orWhere('etat_commande_id', '=', EtatCommande::whereNom("load")->first()->id);
        })->where(function ($query)  use ($client) {
            $query->where('client_id', '=', $client->id);
        })->get();

        if (count($commandes) != 0) {
            $message = "Bonjour " . $client->prenoms . "\nVotre commande chez " . $commercant->boutique->nom . " est annul??. Merci de payer vos commandes en cours.\n\nTRANCHEPAY";
            return [
                "error" => true,
                "sms" => $message,
                "message" => "Le client ne peut pas faire une nouvelle commande."
            ];
        }

        $prix_total = $this->totalCommande($request->produits);

        if ($request->first_part < $prix_total * (1 / 3)) {
            return [
                "error" => true,
                "message" => "Le premier versement doit ??tre sup??rieur ou ??gal ?? 1/3 du montant de la commande."
            ];
        }

        // SI LE COMPTE CLIENT PEUX FAIRE UNE COMMANDE DE CETTE PRIX
        $max = Param::whereCle("max_pay")->first()->valeur;
        if ($client->deplafonner == false && $prix_total > $max) {
            return [
                "error" => true,
                "message" => "Impossible de faire une commande sup??rieur ?? " . $max . " FCFA pour ce client."
            ];
        }

        return [
            "error" => false,
            "prix_total" => $prix_total
        ];
    }

    public function totalCommande($produits)
    {
        $prix_total = 0;
        foreach ($produits as $value) {
            $prix_total += ($value["prix_unitaire"] * $value["quantite"]);
        }
        return $prix_total;
    }

    public function authCommercant()
    {
        $user = User::find(auth()->id());
        return Commercant::with("boutique")->find($user->model);
    }

    public function confirmeClientPayement(Padding $padding, Client $client, Commande $commande, $codePin)
    {
        return $this->confirmePayement($padding, $client, $commande, $codePin);
    }

    public function authClient(): Client
    {
        $user = User::find(auth()->id());
        return Client::find($user->model);
    }



    public function commercantDashBoard()
    {
        $result = [];
        $user = $this->currentUser();
        $etat_commande = EtatCommande::whereNom("append")->first();

        $currentCommercant = Commercant::find($user->model);

        $result['annee'] = $currentCommercant
            ->boutique
            ->commandes()
            ->where("etat_commande_id", "!=", $etat_commande->id)
            ->whereYear("created_at", "=", now())
            ->get()
            ->sum("prix_total");

        $result['mois'] = $currentCommercant
            ->boutique
            ->commandes()
            ->where("etat_commande_id", "!=", $etat_commande->id)
            ->whereYear("created_at", "=", now())
            ->whereMonth("created_at", "=", now())
            ->get()
            ->sum("prix_total");

        $result['jour'] = $currentCommercant
            ->boutique
            ->commandes()
            ->limit(10)
            ->where("etat_commande_id", "!=", $etat_commande->id)
            ->whereYear("created_at", "=", now())
            ->whereMonth("created_at", "=", now())
            ->whereDay("created_at", "=", now())
            ->get()
            ->sum("prix_total");

        $result['ventes'] = $currentCommercant
            ->boutique
            ->commandes()
            ->where("etat_commande_id", "!=", $etat_commande->id)
            ->with(["client", "versements"])
            ->limit(10)
            ->orderBy('created_at', 'desc')
            ->get();

        return $result;
    }

    public function commercantVentes()
    {
        $result = [];
        $user = $this->currentUser();

        $currentCommercant = Commercant::find($user->model);

        $result["tous"] = $currentCommercant
            ->boutique
            ->commandes()
            ->with(['produits', 'versements', 'client', 'etatCommande'])
            ->limit(100)
            ->orderBy('created_at', 'desc')
            ->get();

        $result["en_cours"] = $currentCommercant
            ->boutique
            ->commandes()
            ->with(['produits', 'versements', 'client', 'etatCommande'])
            ->join("etat_commandes", "etat_commandes.id", "commandes.etat_commande_id")
            ->where("etat_commandes.nom", "load")
            ->limit(100)
            ->orderBy('commandes.created_at', 'desc')
            ->get();

        $result["terminer"] = $currentCommercant
            ->boutique
            ->commandes()
            ->with(['produits', 'versements', 'client', 'etatCommande'])
            ->join("etat_commandes", "etat_commandes.id", "commandes.etat_commande_id")
            ->where("etat_commandes.nom", "finish")
            ->limit(100)
            ->orderBy('commandes.created_at', 'desc')
            ->get();

        return $result;
    }

    public function soldeCommercant()
    {
        $commercant = $this->authCommercant();
        $compte = Boutique::with(["compte", "compte.retraits"])->whereId($commercant->boutique->id)->first();
        return $compte;
    }

    public function doRetrait($telephone, $montant, $via)
    {
        $commercant = $this->authCommercant();

        if ($montant > $commercant->boutique->compte->solde) {
            return "Le solde de votre compte est insiffusant pour faire le retrait.";
        }

        $data = [
            "account_alias" => $telephone,
            "amount" => $montant,
            "withdraw_mode" => "orange-money-senegal"
        ];
        $response = $this->sendRetraitRequest($data);
        return response()->json($response);
    }

    public function restant($commande)
    {
        $total_verser = 0;

        foreach ($commande->versements as $value) {
            $total_verser += $value->montant;
        }
        return ($commande->prix_total + $commande->commission) - $total_verser;
    }

    public function uploadImage($file, $path)
    {
        return $file->move(public_path($path), time() . "." . $file->extension());
    }
}
