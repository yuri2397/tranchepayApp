<?php

namespace App\Http\Controllers\Api;

use App\Models\Admin;
use App\Traits\Utils;
use App\Models\Commande;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
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

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                "message" => "Nom d'utilisateur ou mot passe incorrect."
            ], 422);
        }

        return response()->json([
            "token" => $user->createToken($request->device_name),
            "user" => $user,
        ], 200);
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
