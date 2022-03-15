<?php

namespace App\Http\Controllers\Api;

use App\Models\Admin;
use App\Traits\Utils;
use App\Models\Commande;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Client;
use App\Models\Commercant;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            "email" => "required",
            "password" => "required"
        ]);

        $user = Admin::whereEmail($request->email)->first();

        if (!$user || ($request->password!=$user->password)) {
            return response()->json([
                "message" => "Email ou mot passe incorrect."
            ], 422);
        }

        return response()->json([
            "token" => $user->createToken($request->device_name),
            "user" => $user,
        ], 200);
    }


    public function getClients()
    {
        return Client::limit(10)->get();
    }

    public function getCommercants()
    {
        return Commercant::all();
    }

    public function getAdmin()
    {
        return Admin::all();
    }

    public function lastCommandes()
    {
        return Commande::limit(20)->orderBy("created_at", "desc")->get();
    }


    public function progressCommandes()
    {
        return Commande::limit(20)->where("etat_commande_id",2)->get();
    }

    public function finalCommandes()
    {
        return Commande::limit(20)->where("etat_commande_id",3)->get();
    }
}
