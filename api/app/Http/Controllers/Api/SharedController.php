<?php

namespace App\Http\Controllers\Api;

use App\Traits\Utils;
use App\Models\Client;
use App\Models\Partenaire;
use App\Models\ModePayement;
use App\Http\Controllers\Controller;
use App\Models\Padding;
use App\Traits\OMPayement;

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
            }
        }

        return $padding;
    }
}
