<?php

namespace App\Http\Controllers\Api;

use App\Traits\Utils;
use App\Models\Client;
use App\Models\Partenaire;
use App\Models\ModePayement;
use App\Http\Controllers\Controller;
use App\Models\Commande;
use App\Models\EtatCommande;
use App\Models\Padding;
use App\Traits\OMPayement;
use Illuminate\Console\Command;

class SharedController extends Controller
{
    use Utils, OMPayement;
    public function modePaiement($id)
    {
        $client = Client::find($id);
        if ($client && $client->deplafonner == true) {
            return ModePayement::where('nb_mois', "<=", 4)->get();
        }
        return ModePayement::all();
    }

    public function partenaires()
    {
        return Partenaire::all();
    }

    public function checkPadding($reference)
    {
        $padding = Padding::find($reference);
        if ($padding->via == "Orange Money") {
            $status = $this->getPayementStatus($padding->reference);

            if ($status["status"] == "SUCCESS") {
                $padding->status = true;
                $padding->save();
                $set = $this->valideOMPayement($padding);
                if ($set == "ERROR") {
                    $padding->status = false;
                    $padding->save();
                }
            } else if ($status["status"]  == "REJECTED" || $status["status"] == "FAILED") {
                $padding->extra = json_encode("REJECTED");
                $commande = Commande::find($padding->commande_id);
                if ($commande) {
                    $cancel = EtatCommande::whereNom("cancel")->first();
                    $commande->etat_commande_id = $cancel->id;
                    $commande->save();
                }
                return response()->json([
                    "message" => "Votre paiement a été annulé. Merci de réessayer."
                ], 422);
            }
        }

        return $padding;
    }
}
