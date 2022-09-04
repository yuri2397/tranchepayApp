<?php

namespace App\Traits;

use App\Models\Param;
use App\Models\Client;
use App\Models\Compte;
use App\Models\Padding;
use App\Models\Commande;
use App\Models\Versement;
use App\Models\EtatCommande;
use Illuminate\Support\Facades\URL;
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
            'Authorization' => "Bearer $access_token",
            "X-Callback-Url" => URL::to("/api/om/ipm")
        ])->post($this->payementUrl, $data);

        $response = json_decode($response, true);

        if ($response["status"] == "INITIATED") {
            $padding = new Padding();
            $padding->reference = $response["transactionId"];
            $padding->type = $type;
            $padding->user_id = $client->id;
            $padding->via = "Orange Money";
            $padding->amount = $amount;
            $padding->commande_id = $commande->id;
            $padding->save();
            return [
                "response" => $response,
                "padding" => $padding->id
            ];
        }

        return [
            "response" => $response,
            "padding" => null
        ];
    }

    public function OMRetrait($amount, $telephone, $commercant)
    {
    }

    public function valideOMPayement(Padding $padding)
    {
        if ($padding) {

            $padding->extra = json_encode("SUCCESS");
            $padding->status = true;

            $commande = Commande::with("versements")->find($padding->commande_id);

            $versement = new Versement();
            $versement->date_time = now();
            $versement->via = $padding->via;
            $versement->reference = $padding->reference;
            $versement->montant = $padding->amount;
            $versement->commande_id = $commande->id;
            $versement->save();

            if ($padding->type == "fp") {
                $compte = Compte::whereBoutiqueId($commande->boutique_id)->first();
                $compte->solde += $commande->prix_total;
                $compte->save();
            }

            $res = $this->restant($commande);
            $padding->save();

            if ($res == 0) {
                $commande->etat_commande_id = EtatCommande::whereNom("finish")->first()->id;
                $commande->save();
            }
            return "SUCCESS";
        } else {
            return "ERROR";
        }
    }

    public function getPayementStatus($id)
    {
        $url = "https://api.orange-sonatel.com/api/eWallet/v1/transactions/$id/status";

        $access_token = $this->requestOMToken();
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer $access_token"
        ])->get($url);

        return json_decode($response, true);
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

    // public function changePin()
    // {
    //     // new pin 1234
    //     $data = [
    //         "encryptedPinCode" => "OievTqWOt08nZ/XmBVqmtk1nj93/gcpEERKg7+Ag8ZuQQBDDG2bjdp7MO7Q0oKw9kZERHt9ahmYt8cE0R1vVKUp0CenneU0H4J8lfgbZBvPrQyaJY3XA3yaK91RB4YcXn8LTmcIMRv0HegAYth70o69QesMOfQYbSzdYWqw/LuVJMBxz3et8RyeB9XGByV90gMtyb5kMTN8czU6TeUG+21UAN/0+09rjr5suB48ZlBocufHpmP5cR2zs5DdSBPplHaC+fl7aah/VfXsNqDZnG50IHG1fr7AsubPKvAsJHoTIiKRcnkrReY0Y74Lgjeu7ryzVOf7asGDo+mQNPRKzMQ==",
    //         "encryptedNewPinCode" => "atR3wd3Stl/xFoPGuJy35A9+rsLcfRnor6a4W1KLEybUXxlhryHZCVHR44/vivd2jRR9TQ5Mpgz4gMvj3H29aZ1LuMQEcDL3i4+xbA8BTWJrJPrtNHQMI50JxNz4Ar6UFFfMgPuRFlrdARySV9qG6+P7KpEkhdUQRXKx5ak1evQ0dHJptC6EBxWBfKjijPvYcnvOO1Fu/Kxwrulwq4TrvZmdK+1TZ8EPL1x9bidjJ6bEjodtV9HCIV29W5e8mSJp3OV7eesSVZlDX5jyoXyj8M9qtOz1e8lZgG0TAUizC2JL4trIebva6avvNCSsDQW88/sN+CJpOvf9IVhylWf/ng=="
    //     ];

    //     $token = $this->requestOMToken();
    //     $tel = env('OM_MARCHAND_PONE');
    //     $response = Http::withHeaders([
    //         'Authorization' => "Bearer " . $token
    //     ])->patch("https://api.orange-sonatel.com/api/eWallet/v1/account?msisdn=" . $tel, $data);


    //     return $response;
    // }
}
