<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PayementIPN extends Controller
{
    public function wave(Request $request)
    {
        $wave_webhook_secret = env("WAVE_WEB_HOOK");

        $wave_signature = $_SERVER['HTTP_WAVE_SIGNATURE'];

        $parts = explode(",", $wave_signature);
        $timestamp = explode("=", $parts[0])[1];

        $signatures = array();
        foreach (array_slice($parts, 1) as $signature) {
            $signatures[] = explode("=", $signature)[1];
        }
        $body = $request->all();
        $computed_hmac = hash_hmac("sha256", $timestamp . json_encode($body), $wave_webhook_secret);
        $valid = in_array($computed_hmac, $signatures);

        if ($valid) {

            $webhook_event = $body['type'];
            $webhook_data = $body['data'];

            switch ($webhook_event) {
                case 'checkout.session.completed':

                    break;
                case 'checkout.session.expired':

                    break;

                case 'checkout.session.payment_failed':

                break;
            }


            return response()->json(["message" => "Request success"], 200);
        } else {
            die("Unable to verify webhook signature.");
        }
    }
    public function orangeMoney(Request $request)
    {
        return response()->json(["message" => "Request success"], 200);
    }

    public function free(Request $request)
    {
        return response()->json(["message" => "Request success"], 200);
    }
}
