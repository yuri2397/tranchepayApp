<?php

namespace App\Http\Controllers;

use App\Models\Log;
use App\Models\User;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\Commande;
use App\Models\Commercant;
use App\Traits\OMPayement;
use App\Traits\FreePayement;
use App\Traits\WavePayement;
use Illuminate\Http\Request;

class TestController extends Controller
{
    use OMPayement, WavePayement, Utils, FreePayement;
    public function index(Request $request)
    {
        return orange()->sendSMS("BONJOUR MOR DIAW", "221781879981");
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
}
