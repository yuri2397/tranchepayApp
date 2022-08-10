<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Commande;
use App\Models\Log;
use App\Traits\FreePayement;
use App\Traits\OMPayement;
use App\Traits\Utils;
use App\Traits\WavePayement;
use Illuminate\Http\Request;

class TestController extends Controller
{
    use OMPayement, WavePayement, Utils, FreePayement;
    public function index(Request $request)
    {
        // return $this->changePin();
        return $this->requestOMToken($request->amount,"781879981", Client::first(), Commande::all()[0], 'vs');
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
