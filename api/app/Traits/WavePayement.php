<?php

namespace App\Traits;

use App\Models\Padding;
use Illuminate\Support\Facades\Http;

trait WavePayement
{
    protected $waveBaseUrl = "https://api.wave.com";
    protected $errorUrl = "https://api.tranchepay.com/api/ipn/wave/error";
    protected $successUrl = "https://tranchepay.com/payement-sucess?type=c";

    public function createCheckoutSession($amount, $client, $commande)
    {

        $data = array(
            'amount' => $amount,
            'currency' => 'XOF',
            'error_url' => $this->errorUrl,
            'success_url' => $this->successUrl,
            'client_reference' => $commande->reference
        );
        
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer " . env('WAVE_OAUTH_TOKEN')
        ])->post($this->waveBaseUrl, $data);

        $padding = new Padding();
        $padding->reference = $commande->reference;
        $padding->type = "wave-payement";
        $padding->user_id = $client->id;
        $padding->save();
        
        return $response;
    }
}
