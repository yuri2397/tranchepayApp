<?php

namespace App\Traits;

use App\Models\Padding;
use Illuminate\Support\Facades\Http;

trait WavePayement
{
    protected $errorUrl = "";
    protected $successUrl = "https://tranchepay.com/payement_success?";

    public function createCheckoutSession($amount, $client, $commande, $type)
    {
        $data = array(
            'amount' => $amount,
            'currency' => 'XOF',
            'error_url' => "https://tranchepay.com/payement-error?via=wave&ci=".$client->id."&cdi=".$commande->id,
            'success_url' => "https://tranchepay.com/payement_success?via=wave&ci=".$client->id."&cdi=".$commande->id,
            'client_reference' => $commande->reference
        );

        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer " . env('WAVE_OAUTH_TOKEN')
        ])->post(env('WAVE_CHECKOUT_SESSION_URL'), $data);

        $padding = new Padding();
        $padding->reference = $response['id'];
        $padding->type = $type;
        $padding->user_id = $client->id;
        $padding->via = "Wave";
        $padding->amount = $amount;
        $padding->save();

        return [
            "padding" => $padding->id,
            "response" => $response
        ];
    }

    public function getSession(WaveSession $session)
    {
        $url = "https://api.wave.com/v1/checkout/sessions/" . $session->getId();

        $response = Http::withHeaders([
            'Authorization' => "Bearer " . env('WAVE_OAUTH_TOKEN')
        ])->get($url);

        return $response;
    }
}
