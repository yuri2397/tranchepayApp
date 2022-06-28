<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PayementIPN extends Controller
{
    public function wave(Request $request)
    {
        return response()->json(["message" => "Request success"], 200);
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
