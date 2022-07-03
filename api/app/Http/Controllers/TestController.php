<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Commande;
use App\Models\Log;
use App\Traits\OMPayement;
use App\Traits\WavePayement;
use Illuminate\Http\Request;

class TestController extends Controller
{
    use OMPayement, WavePayement;
    public function index(Request $request)
    {
        // return $request->getHost();
        $wave_signature = "t=1656853270,v1=1b73c1799749cbbdecb589f8a5c6a57cc3b2d04b83e663ec627c01ea385715fa";
        $parts = explode(",", $wave_signature);
        $timestamp = explode("=", $parts[0])[1];
        $wave_webhook_secret = env("WAVE_WEB_HOOK");

        $signatures = array();
        foreach (array_slice($parts, 1) as $signature) {
            $signatures[] = explode("=", $signature)[1];
        }
        $body = $request->all();

        $computed_hmac = hash_hmac("sha256", json_encode($body). $timestamp, $wave_webhook_secret);

        return [
            "s" => $signatures,
            "h" => $computed_hmac,
        ];
    }


    public function allLogs()
    {
        $logs = Log::all();

        return array_map(function ($a) {
            return [
                "text" => $a['text'],
                "log" => json_decode($a['log'])
            ];
        }, $logs->toArray());
    }

    /**
     * Store a newly created resource in storage.
     *
     * 
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
