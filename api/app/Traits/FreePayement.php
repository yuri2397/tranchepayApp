<?php

namespace App\Traits;

use App\Models\Padding;
use App\Models\Log;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Http;

trait FreePayement
{
    public function requestFreePayement($amount, $telephone, $client, $commande, $type)
    {
        $data = [
            "amount" => $amount,
            "currency" => "XOF",
            "agentmsisdn" => env("FREE_AGENT_USERNAME"),
            "customermsisdn" => "221" . $telephone,
            "password" => env("FREE_AGENT_PIN"),
            "externaltransactionid" => $commande->reference,
            "username" => env("FREE_AGENT_USERNAME")
        ];
        
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
        ])->post("https://gateway.free.sn/Live/paiementmarchand", $data);

            
        if(json_decode($response, true)){
            $padding = new Padding();
            $padding->reference = "free_" . Str::random();
            $padding->type = $type;
            $padding->user_id = $client->id;
            $padding->via = "Free Money";
            $padding->amount = $amount;
            $padding->commande_id = $commande->id;
            $padding->save();
            return [
                "response" => $response,
                "padding" => $padding->id
            ];
        }

        return [
            "response" => json_decode($response),
            "padding" => null
        ];
    }

    public function isValideFreeNumber($telephone)
    {
        if($telephone && Str::length(formatOnePhone($telephone, false)) == 12){
            $telephone = Str::substr(formatOnePhone($telephone, false), 3);
        }
        $test = str_split($telephone);
        
        if ($test && $test[0] == "7" && ($test[1] == "6")) {
            return $telephone;
        }

        return false;
    }
}
