<?php

namespace App\Traits;

use App\Models\Client;
use App\Models\Padding;
use App\Models\Commande;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;

class FreePayement
{
    public function requestPayement($amount, Client $client, Commande $commande, $type)
    {
        $data = [
            "amount" => $amount,
            "currency" => "XOF",
            "agentmsisdn" => env("FREE_AGENT_USERNAME"),
            "customermsisdn" => "221" . $client->telephone,
            "password" => env("FREE_AGENT_PIN"),
            "externaltransactionid" => $commande->reference,
            "username" => env("FREE_AGENT_USERNAME")
        ];
        $access_token = env('FREE_TOKEN');
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer $access_token"
        ])->post("https://gateway.free.sn/Live/paiementmarchand", $data);

        $padding = new Padding();
        $padding->reference = "free_" . Str::random();
        $padding->type = $type;
        $padding->user_id = $client->id;
        $padding->via = "Free Money";
        $padding->amount = $amount;
        $padding->commande_id = $commande->id;
        $padding->save();

        return json_decode($response);
    }
}
