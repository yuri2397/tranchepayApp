<?php

namespace App\Http\Controllers;

use App\Models\Commande;
use App\Models\Compte;
use App\Models\EtatCommande;
use App\Models\Log;
use App\Models\Padding;
use App\Models\Versement;
use App\Traits\Utils;
use Illuminate\Http\Request;

class PayementIPN extends Controller
{
    use Utils;

    public function wave(Request $request)
    {
        $body = $request->all();
        $webhook_event = $body['type'];
        $data = $body['data'];

        switch ($webhook_event) {
            case 'checkout.session.completed':
                $padding = Padding::whereReference($data['id'])->whereStatus(false)->first();

                if ($padding) {

                    $padding->extra = json_encode($body);
                    $padding->status = true;

                    $commande = Commande::with("versements")->find($padding->commande_id);

                    $versement = new Versement();
                    $versement->date_time = now();
                    $versement->via = 'Wave';
                    $versement->reference = $data['id'];
                    $versement->montant = $data['amount'];
                    $versement->commande_id = $commande->id;
                    $versement->save();

                    if ($padding->type == "fp") {
                        $compte = Compte::whereBoutiqueId($commande->boutique_id)->first();
                        $compte->solde += $commande->prix_total;
                        $compte->save();
                    }
                    $message = "Votre paiement de " . $data['amount'] . ' FCFA avec WAVE est validé avec succès.';

                    $res = $this->restant($commande);
                    $padding->save();
                    if ($res == 0) {
                        $message = $message . ' Votre commande est entierement payé.';
                        $commande->etat_commande_id = EtatCommande::whereNom("finish")->first()->id;
                        $commande->save();
                    } else {
                        $message = $message . ' Votre commande cous sera livré une fois tout payer.';
                    }

                    $this->sendSMS($message, $commande->client->telephone);
                    return response()->json([], 200);
                }
                break;
        }
        return response()->json(["message" => "Request success"], 200);
    }

    public function orangeMoney(Request $request)
    {
        $log = new Log();
        $log->text = "OM IPN LOG";
        $log->log = json_encode($request->all());
        $log->save();
        return response()->json(["message" => "Request success"], 200);
    }

    public function free(Request $request)
    {
        $log = new Log();
        $log->text = "FREE IPN LOG";
        $log->log = json_encode($request->all());
        $log->save();

        $body = $request->all();
        $padding = Padding::whereReference($body['externalId'])->whereStatus(false)->first();
        if ($padding) {
            switch ($body['status']) {
                case 'APPROVED':
                    if ($padding) {
                        $padding->extra = json_encode($body);
                        $padding->status = true;

                        $commande = Commande::with("versements")->find($padding->commande_id);

                        $versement = new Versement();
                        $versement->date_time = now();
                        $versement->via = 'Free Money';
                        $versement->reference = $body['externalId'];
                        $versement->montant = $body['amount'];
                        $versement->commande_id = $commande->id;
                        $versement->save();

                        if ($padding->type == "fp") {
                            $compte = Compte::whereBoutiqueId($commande->boutique_id)->first();
                            $compte->solde += $commande->prix_total;
                            $compte->save();
                        }

                        $res = $this->restant($commande);
                        $padding->save();
                        $log->text = $res;
                        $log->save();

                        if ($res == 0) {
                            $commande->etat_commande_id = EtatCommande::whereNom("finish")->first()->id;
                            $commande->save();
                        }
                        return response()->json([], 200);
                    }
                    break;
                case 'REJECTED':
                    $padding->delete();
                    break;
            }
        }
        return response()->json(["message" => "Request success"], 200);
    }
}
