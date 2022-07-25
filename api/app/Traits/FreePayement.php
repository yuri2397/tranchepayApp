<?php

namespace App\Traits;

use App\Models\Client;
use App\Models\Padding;
use App\Models\Commande;
use App\Models\Log;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;

trait FreePayement
{
    public function requestFreePayement($amount, $client, $commande, $type)
    {
        $data = [
            "amount" => $amount,
            "currency" => "XOF",
            "agentmsisdn" => env("FREE_AGENT_USERNAME"),
            "customermsisdn" => "221763052658",
            "password" => env("FREE_AGENT_PIN"),
            "externaltransactionid" => $commande->reference,
            "username" => env("FREE_AGENT_USERNAME")
        ];
        // $access_token = env('FREE_TOKEN');
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
        ])->post("https://gateway.free.sn/Live/paiementmarchand", $data);

        $log = new Log();
        $log->text = "TESTE";
        $log->log = json_encode($data);
        $log->save();
        
        // $padding = new Padding();
        // $padding->reference = "free_" . Str::random();
        // $padding->type = $type;
        // $padding->user_id = $client->id;
        // $padding->via = "Free Money";
        // $padding->amount = $amount;
        // $padding->commande_id = $commande->id;
        // $padding->save();

        // return [
        //     "response" => $response,
        //     "padding" => $padding->id
        // ];

        return $response;
    }
}
