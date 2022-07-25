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
        $log = new Log();
        $log->text = "FREE SEND REQUEST TESTS";
        $log->log = json_encode($data);
        $log->save();
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
        ])->post("https://gateway.free.sn/Live/paiementmarchand", $data);

        

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

    public function isValideFreeNumber($telephone)
    {
        $test = str_split($telephone);
        if ($test && $test[0] == "7" && $test[1] == 6) {
            return true;
        }

        return false;
    }
}
