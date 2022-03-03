<?php

namespace App\Traits;

use Paydunya\Setup;
use Paydunya\Checkout\Store;
use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Http;
use PHPUnit\Framework\MockObject\Exception;

trait Paydunya
{
    public function initPayement()
    {
        Setup::setMasterKey(env("PAYDUNYA_MASTER_KEY"));
        Setup::setPublicKey(env("PAYDUNYA_PUBLIC_KEY"));
        Setup::setPrivateKey(env("PAYDUNYA_PRIVATE_KEY"));
        Setup::setToken(env("PAYDUNYA_TOKEN"));
        Setup::setMode("test");

        Store::setName(env("APP_NAME"));
        Store::setTagline("Payer vos commandes par tranche.");
        Store::setPhoneNumber("+336530583");
        Store::setPostalAddress("Dakar Plateau - Etablissement kheweul");
        Store::setWebsiteUrl("https://tranchepay.com");
        Store::setLogoUrl("https://image.freepik.com/vecteurs-libre/couronne-or-ligne-vague_1017-33680.jpg");
        Store::setCallbackUrl(env("CLIENT_IPN"));
    }

    public function setReturnUrl($url){
        Store::setReturnUrl($url);
    }

    public function setCancelUrl($url)
    {
        Store::setCancelUrl($url);

    }

    public function sendRetraitRequest($data)
    {
        $ch = curl_init(env("PAYDUNYA_RETRAIT_URL"));
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
            "Content-Type: application/json",
            "PAYDUNYA-MASTER-KEY: " . env("PAYDUNYA_MASTER_KEY"),
            "PAYDUNYA-PRIVATE-KEY: " . env("PAYDUNYA_PRIVATE_KEY"),
            "PAYDUNYA-TOKEN: " . env("PAYDUNYA_TOKEN"),
        ));

        $rawResponse = curl_exec($ch);
        return $rawResponse;
    }
}