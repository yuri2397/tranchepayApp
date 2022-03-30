<?php

namespace App\Http\Controllers\Api;

use App\Models\Admin;
use App\Traits\Utils;
use App\Models\Commande;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Client;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Hash;
use App\Models\Commercant;


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

    public function registerAdmin(Request $request)
    {
        $this->validate($request, [
            'full_name' => 'required|string',
            'email' => 'required|string',
            'password' =>"required|min:8",
        ]);

        try{
            $admin=new  Admin();
            $admin->full_name=$request->full_name;
            $admin->email=$request->full_name;
            $admin->password=Hash::make($request->password);
            $admin->save();
            return response()->json($admin, 201);
        }
        catch (\Throwable $th) {
            return response()->json([
                'message' => $th
            ], 500);
        }

    }

    public function getClients()
    {
        return Client::limit(10)->get();
    }

    public function getCommercants()
    {
        return Commercant::with(['boutique','boutique.commandes'])->get();
    }

    public function showCommercantById($id)
    {
        return Commercant::with(['boutique','boutique.commandes'])
        ->whereId($id)
        ->first();
    }
    public function ShowClienById($id)
    {
        return Client::with(['commandes'])
        ->whereId($id)
        ->first();
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

    public function getCommandeByBoutiqueId(string $id)
    {
        return Commande::limit(20)->where("boutique_id",$id)->get();
    }


    public function findcommandeByClienId($id)
    {
        return Commande::limit(20)->where("client_id",$id)->get();
    }

    public function findcommande($id)
    {
        return Commande::with(['versements','produits'])
        ->whereId($id)->first();
    }


    public function findCommercantInactif()
    {
        return Commercant::lmit(5)->where('created_at',null)->orderBy("created_at", "desc")->get();
    }

}
