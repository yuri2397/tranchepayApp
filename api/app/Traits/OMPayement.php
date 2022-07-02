<?php

namespace App\Traits;

use App\Models\Client;
use App\Models\Commande;
use App\Models\Padding;
use App\Models\Param;
use Illuminate\Support\Facades\Http;
use Dirape\Token\Token;

trait OMPayement
{

    protected $baseUrl = "https://api.sandbox.orange-sonatel.com";
    protected $tokenUrl = "https://api.sandbox.orange-sonatel.com/oauth/token";
    protected $initUrl = "https://api.sandbox.orange-sonatel.com/api/eWallet/v1/payments";
    protected $publicKeyUrl = "https://api.sandbox.orange-sonatel.com/api/account/v1/publicKeys";
    protected $payementUrl = "https://api.sandbox.orange-sonatel.com/api/eWallet/v1/payments";
    protected $oneStapUrl = "https://api.sandbox.orange-sonatel.com/api/eWallet/v1/payments/onestep";

    private function requestOMToken()
    {
        $data = [
            "grant_type" => "client_credentials",
            "client_secret" => env('OM_CLIENT_SECRET'),
            "client_id" => env('OM_CLIENT_ID')
        ];

        $ch = curl_init($this->tokenUrl);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array_merge([
            'Content-Type: application/x-www-form-urlencoded;charset=utf-8',
            'Content-Length: ' . mb_strlen(http_build_query($data))
        ]));

        $rawResponse = curl_exec($ch);

        $jsonResponse = json_decode($rawResponse, true);
        return $jsonResponse['access_token'];
    }

    public function requestOMPayement(int $amount, Commande $commande, Client $client, $type)
    {
        $data = [
            'method' => 'CLASSIC',
            'partner' => [
                'idType' => 'MSISDN',
                'id' => env('MARCHAND_PONE'),
                'encryptedPinCode' => env('MARCHAND_HASH_CODE')
            ],
            'customer' => [
                'idType' => 'MSISDN',
                'id' => $client->telephone
            ],
            'metadata' => [
                "client" => $client->id,
                "client_phone" => $client->telephone,
                "commande" => $commande->id
            ],
            'amount' => [
                'value' => $amount,
                'unit' => 'XOF'
            ],
            'reference' => (new Token())->Unique('paddings', 'reference', 45),
            'receiveNotification' => false
        ];
        $access_token = $this->requestOMToken();
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer $access_token"
        ])->post($this->payementUrl, $data);

        $response = json_decode($response, true);

        $padding = new Padding();
        $padding->reference = $response['transactionId'];
        $padding->type = $type;
        $padding->user_id = $client->id;
        $padding->via = "Orange Money";
        $padding->amount = $amount;
        $padding->save();

        return $response;
    }

    public function getPublicKey()
    {
        return Param::whereCle("om_public_key")->first()->value;
    }

    public function initOMPayement($amount, $clientPhone)
    {
        $data = array(
            'method' => 'CLASSIC',
            'partner' =>
            [
                'idType' => 'MSISDN',
                'id' => env('MARCHAND_PONE'),
                'encryptedPinCode' => "1234",
            ],
            'customer' =>
            [
                'idType' => 'MSISDN',
                'id' => '{numéro client}',
            ],
            'metadata' => [],
            'amount' =>
            [
                'value' => 1,
                'unit' => 'XOF',
            ],
            'reference' => 'test_1',
            'receiveNotification' => false,
        );
        $access_token = $this->requestOMToken();
        $ch = curl_init($this->payementUrl);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array_merge([
            'Content-Type: application/json',
            'Content-Length: ' . mb_strlen(http_build_query($data))
        ]));

        $rawResponse = curl_exec($ch);

        $jsonResponse = json_decode($rawResponse, true);
        return $jsonResponse['access_token'];
    }

    public function confirmePayement(Padding $padding, Client $client, Commande $commande, $codePin)
    {
        $data = [
            "idType" => "MSISDN",
            "id" => $client->telephone,
            "encryptedPinCode" => $this->hashPin($codePin)
        ];
        $access_token = $this->requestOMToken();
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer $access_token"
        ])->post("https://api.sandbox.orange-sonatel.com/api/eWallet/v1/transactions/" . $padding->reference . "/confirm", $data);

        return json_decode($response);
    }

    public function oneStapOMPayement()
    {
    }

    public function hashPin($codePin)
    {
        if (openssl_public_encrypt($codePin, $encrypted, $this->getPublicKey()))
            $data = base64_encode($encrypted);
        else
            throw new \Exception('Unable to encrypt data. Perhaps it is bigger than the key size?');
        return $data;
    }
}
