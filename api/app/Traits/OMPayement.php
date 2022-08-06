<?php

namespace App\Traits;

use App\Models\Client;
use App\Models\Commande;
use App\Models\Padding;
use App\Models\Param;
use Illuminate\Support\Facades\Http;

trait OMPayement
{

    protected $baseUrl = "https://api.orange-sonatel.com";
    protected $tokenUrl = "https://api.orange-sonatel.com/oauth/token";
    protected $initUrl = "https://api.orange-sonatel.com/api/eWallet/v1/payments";
    protected $publicKeyUrl = "https://api.orange-sonatel.com/api/account/v1/publicKeys";
    protected $payementUrl = "https://api.orange-sonatel.com/api/eWallet/v1/payments";
    protected $oneStapUrl = "https://api.orange-sonatel.com/api/eWallet/v1/payments/onestep";

    private function requestOMToken()
    {
        $data = [
            "grant_type" => "client_credentials",
            "client_id" => "cd46cbd1-5991-4e10-afac-d0573a32dd1d",
            "client_secret" => "6560b034-c3b1-42c6-bfe3-ec409adae457"
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

    public function requestOMPayement(int $amount, $telephone, $client, Commande $commande, $type)
    {
        $ref = uniqid("om_");

        $data = [
            'method' => 'CLASSIC',
            'partner' => [
                'idType' => 'MSISDN',
                'id' => env('OM_MARCHAND_PONE'),
                'encryptedPinCode' => env('OM_MARCHAND_HASH_CODE')
            ],
            'customer' => [
                'idType' => 'MSISDN',
                'id' => $telephone
            ],
            'amount' => [
                'value' => $amount,
                'unit' => 'XOF'
            ],
            'reference' => $commande->reference,
            'receiveNotification' => true
        ];
        $access_token = $this->requestOMToken();

        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer $access_token"
        ])->post($this->payementUrl, $data);

        $response = json_decode($response, true);

        $padding = new Padding();
        $padding->reference = $commande->reference;
        $padding->type = $type;
        $padding->user_id = $client->id;
        $padding->via = "Orange Money";
        $padding->amount = $amount;
        $padding->commande_id = $commande->id;
        $padding->save();

        return [
            "response" => $response,
            "padding" => $padding
        ];
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

    public function isValideOrangeNumber($telephone)
    {
        $test = str_split($telephone);
        if ($test && $test[0] == "7" && ($test[1] == "7" || $test[1] == "5" || $test[1] == "8")) {
            return true;
        }

        return false;
    }

    private function requestPublicKey($token)
    {
        $response = Http::withHeaders([
            'Authorization' => "Bearer " . $token
        ])->get("https://api.orange-sonatel.com/api/account/v1/publicKeys");
        return $response;
    }

    public function changePin()
    {
        $data = [
            "encryptedNewPinCode" => "VJ7tQ+b6MOyjM2lffU5plIjh808m1HrfqjEpvUaeRUqjswNowvybxCSSBAM6Nol5cU35ZK3E7nrH8pMF9dH22YJ4HWqA2qysU88jHJ+CgpTESgunWxHGO8sVflBl/oALsGpk7ja4uj/KaksZs5lhyhDWkS9fVVASJhVl/YBE7wpASaJEeKzBT1seCpCnCBaJrxhCYmeJDV8oFb3zowrn2rKCAMzq1cce4QsowqVnT12j6cU1yJJ3GqVeSLFmORLPxKJ60D8EOHoR6DoZ2/u+7Hu2ftAcKaqkMY4d+GjDfM4de7sei3AWBR+6kfrdDx3gdYbV5TcAcrLwuAgehEeyPw==",
            "encryptedPinCode" => env('OM_MARCHAND_HASH_CODE')
        ];

        $token = $this->requestOMToken();
        $tel = env('OM_MARCHAND_PONE');
        $response = Http::withHeaders([
            'Authorization' => "Bearer " . $token
        ])->patch("https://api.orange-sonatel.com/api/eWallet/v1/account?msisdn=". $tel, $data);


        return $response;
    }
}
