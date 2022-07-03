<?php

namespace App\Http\Controllers;

use App\Models\Client;
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
        $log = new Log();
        $log->log = json_encode($request->all());
        $log->text = $request->header('WAVE_SIGNATURE');
        $log->save();
        $wave_webhook_secret = env("WAVE_WEB_HOOK");

        $wave_signature = $request->header('WAVE_SIGNATURE');

        $parts = explode(",", $wave_signature);
        $timestamp = explode("=", $parts[0])[1];

        $signatures = array();
        foreach (array_slice($parts, 1) as $signature) {
            $signatures[] = explode("=", $signature)[1];
        }
        $body = $request->all();
        $computed_hmac = hash_hmac("sha256", $timestamp . json_encode($body), $wave_webhook_secret);
        $valid = in_array($computed_hmac, $signatures);

        if ($valid) { 

            $webhook_event = $body['type'];
            $data = $body['data'];

            switch ($webhook_event) {
                case 'checkout.session.completed':
                    $padding = Padding::whereReference($body['id'])->whereStatus(false)->first();

                    if ($padding) {

                        $padding->extra = json_encode($body);
                        $padding->status = true;
                        $padding->save();

                        $commande = Commande::find($padding->commande_id);
                        $commande->etat_commande_id = EtatCommande::whereNom("load")->first()->id;
                        $commande->save();

                        $versement = new Versement();
                        $versement->date_time = now();
                        $versement->via = 'Wave';
                        $versement->reference = $body['id'];
                        $versement->montant = $data['amount'];
                        $versement->commande_id = $commande->id;
                        $versement->save();

                        $res = $this->restant($commande);
                        if ($padding->type == "fp") {
                            $compte = Compte::whereBoutiqueId($commande->boutique_id)->first();
                            $compte->solde += $commande->prix_total;
                            $compte->save();
                        }
                        if ($res == 0) {
                            $commande->etat_commande_id = EtatCommande::whereNom("finish")->first()->id;
                            $commande->save();
                        }
                        $padding->save();
                        return response()->json([], 200);
                    }
                    break;
            }
            return response()->json(["message" => "Request success"], 200);
        } else {
            die("Unable to verify webhook signature.");
        }
    }
    public function orangeMoney(Request $request)
    {
        return response()->json(["message" => "Request success"], 200);
    }

    public function free(Request $request)
    {
        return response()->json(["message" => "Request success"], 200);
    }
}
