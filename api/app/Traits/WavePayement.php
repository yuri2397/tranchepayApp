<?php

namespace App\Traits;

use App\Models\Padding;
use Illuminate\Support\Facades\Http;

trait WavePayement
{
<<<<<<< HEAD
    protected $baseUrl = "https://api.wave.com";
    protected $errorUrl = "https://api.tranchepay.com/api/ipn/wave/error";
    protected $successUrl = "https://tranchepay.com/payement-sucess?type=c";

    public function requestWavePayement($amount, $client, $commande)
=======
    
    protected $errorUrl = "https://tranchepay.com/payement-error?via=wave";
    protected $successUrl = "https://tranchepay.com/payement-sucess?type=c";
    public function createCheckoutSession($amount, $client, $commande)
>>>>>>> 0b28418 (some change)
    {

        $data = array(
            'amount' => $amount,
            'currency' => 'XOF',
            'error_url' => $this->errorUrl,
            'success_url' => $this->successUrl,
            'client_reference' => $commande->reference,
            'override_business_name' => env('APP_NAME')
        );
        $access_token = $this->requestOMToken();
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer " . env('WAVE_OAUTH_TOKEN')
<<<<<<< HEAD
        ])->post($this->baseUrl);
=======
        ])->post(env('WAVE_CHECKOUT_SESSION_URL'), $data);
>>>>>>> 0b28418 (some change)

        $padding = new Padding();
        $padding->reference = $commande->reference;
        $padding->type = "wave-payement";
        $padding->user_id = $client->id;
        $padding->save();
        
        return json_decode($response);
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
