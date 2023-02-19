<?php

namespace App\Traits;

use App\Models\Param;
use Mockery\CountValidator\Exception;
use Firebase\JWT\ExpiredException;

trait Notification
{

    public function sendSMS($message, $phone_number)
    {
        return 'ok';
        $dev_phone_number = env("DEV_PHONE_NUMBER");

        $access_token = Param::whereCle("access_token")
            ->where("updated_at", ">=", now()->subHours(1))
            ->first();
        if ($access_token == null) {
            $response = $this->demandeSMSToken();
            if ($response == null || !array_key_exists('access_token', $response))
                throw new ExpiredException(json_encode($response));
            $access_token = Param::whereCle("access_token")->first();
            $access_token->valeur = $response['access_token'];
            $access_token->save();
        }


        $data = [
            "outboundSMSMessageRequest" => [
                "address" => "tel:" . $phone_number,
                "outboundSMSTextMessage" => [
                    "message" => $message
                ],
                "senderAddress" => "tel:+" . $dev_phone_number,
                "senderName" => "TranchePay"
            ]
        ];

        $ch = curl_init("https://api.orange.com/smsmessaging/v1/outbound/tel%3A%2B$dev_phone_number/requests");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Content-Type: application/json",
            "Authorization: Bearer " . $access_token->valeur,
        ));

        $rawResponse = curl_exec($ch);

        if ($rawResponse === false) {
            throw new Exception('Erreur Curl : ' . curl_error($ch));
        } else {
            $jsonResponse = json_decode($rawResponse, true);
            return $jsonResponse;
        }

        
    }

    public function demandeSMSToken()
    {

        $data = [
            "grant_type" => "client_credentials"
        ];
        $authorization_header = env("AUTHORIZATION_HEADER");

        $ch = curl_init("https://api.orange.com/oauth/v3/token");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Authorization: $authorization_header",
            "Content-Type: application/x-www-form-urlencoded",
            'Content-Length:' . mb_strlen(http_build_query($data)),
        ));

        $rawResponse = curl_exec($ch);

        $jsonResponse = json_decode($rawResponse, true);
        return $jsonResponse;
    }

    public function soldeSMS()
    {

        $access_token = Param::whereCle("access_token")
            ->where("updated_at", ">=", now()->subHours(1))
            ->first();
        if ($access_token == null) {
            $response = $this->demandeSMSToken();
            $access_token = Param::whereCle("access_token")->first();
            $access_token->valeur = $response['access_token'];
            $access_token->save();
        }

        $ch = curl_init("https://api.orange.com/sms/admin/v1/contracts");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Content-Type: application/json",
            "Authorization: Bearer " . $access_token->valeur,
        ));

        $rawResponse = curl_exec($ch);

        $jsonResponse = json_decode($rawResponse, true);
        return $jsonResponse;
    }

    public function bilanSMS()
    {
        $access_token = Param::whereCle("access_token")
            ->where("updated_at", ">=", now()->subHours(1))
            ->first();
        if ($access_token == null) {
            $response = $this->demandeSMSToken();
            $access_token = Param::whereCle("access_token")->first();
            $access_token->valeur = $response['access_token'];
            $access_token->save();
        }

        $ch = curl_init("https://api.orange.com/sms/admin/v1/statistics");
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "GET");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Content-Type: application/json",
            "Authorization: Bearer " . $access_token->valeur,
        ));

        $rawResponse = curl_exec($ch);

        $jsonResponse = json_decode($rawResponse, true);
        return $jsonResponse;
    }
}
