<?php

namespace App\Http\Controllers\Api;

use App\Traits\Utils;
use App\Models\Client;
use App\Models\Partenaire;
use App\Models\ModePayement;
use App\Http\Controllers\Controller;

class SharedController extends Controller
{
    use Utils;
    public function modePaiement($id)
    {
        $client = Client::find($id);
        if($client && $client->deplafonner == true){
            return ModePayement::where('nb_mois', "<=", 4)->get();
        }
        return ModePayement::all();
    }

    public function partenaires()
    {
        return Partenaire::all();
    }
}
