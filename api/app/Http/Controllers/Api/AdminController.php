<?php

namespace App\Http\Controllers\Api;

use App\Models\User;
use App\Models\Admin;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\Commande;
use App\Mail\SendHelpMail;
use App\Models\Commercant;
use Illuminate\Support\Str;
use App\Traits\Notification;
use Illuminate\Http\Request;
use App\Mail\SendPasswordMail;
use App\Http\Controllers\Controller;
use App\Models\EtatCommande;
use App\Models\ModePayement;
use App\Models\Param;
use App\Models\Partenaire;
use App\Models\PartenaireType;
use Carbon\Carbon;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Spatie\Permission\Models\Permission;

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
                "message" => "Email ou mot passe incorrect."
            ], 422);
        }

        return response()->json([
            "token" => $user->createToken($request->device_name),
            "user" => $user,
        ], 200);
    }

    public function logout()
    {
        $user = Admin::find(auth()->id());
        $user->token()->revoke();
        return response()->json([], 200);
    }

    public function getClients()
    {
        return Client::limit(10)->get();
    }

    public function getCommercants()
    {
        return Commercant::with(['boutique'])->get();
    }

    public function showCommercantById($id)
    {
        return Commercant::with(['boutique', 'boutique.commandes'])
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
        return Commande::limit(20)->where("etat_commande_id", EtatCommande::whereNom("load")->first()->id)->get();
    }

    public function finalCommandes()
    {
        return Commande::where("etat_commande_id", EtatCommande::whereNom("finish")->first()->id)->get();
    }

    public function getCommandeByBoutiqueId(string $id)
    {
        return Commande::limit(20)->where("boutique_id", $id)->get();
    }


    public function findcommandeByClienId($id)
    {
        return Commande::limit(20)->where("client_id", $id)->get();
    }

    public function findcommande($id)
    {
        return Commande::with(['versements', 'produits'])
            ->whereId($id)->first();
    }


    public function findCommercantInactif()
    {
        return Commercant::lmit(5)->where('created_at', null)->orderBy("created_at", "desc")->get();
    }

    public function registerAdmin(Request $request)
    {
        $this->validate($request, [
            'full_name' => 'required|string',
            'email' => 'required|string',
            'permissions' => 'required|array',

        ]);
        try {
            $password = Str::random(6);
            $admin = new Admin();
            $admin->full_name = $request->full_name;
            $admin->email = $request->email;
            $admin->password = bcrypt($password);
            $admin->givePermissionTo($request->permissions);
            $admin->save();
            return Mail::to($request->email)->send(new SendPasswordMail($request->email, $request->full_name, $password));
            //return response()->json($password, 201);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => $th
            ], 500);
        }
    }


    public function ShowAdminById($id)
    {
        return Admin::Where('id', $id)->first();
    }

    public function ShowMissingPermission(Request $request)
    {

        $permissions = (array)$request->permissions;

        $permission = Permission::all();

        foreach ($permission as $p) {

            return Permission::Where($p->name, '!=', $permissions[0]->name)->get();
        }
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Admin::find($id)->delete();
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

        $admin = $request->all();
        Admin::find($id)->update($admin);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function DesactiveCompte(Request $request, $id)
    {

        $commercant = Commercant::find($id);
        if ($commercant->created_at != null) {
            $commercant->created_at = null;
        }

        $commercant->update();
    }
    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function ActiveCompte(Request $request, $id)
    {

        $commercant = Commercant::find($id);
        if ($commercant->created_at == null) {
            $commercant->created_at = Carbon::today();
        }

        $commercant->update();
    }


    public function partanaires()
    {
        return Partenaire::all();
    }

    public function createPartenaire(Request $request)
    {
        $request->validate([
            "nom" => "required",
            "logo_url" => "required",
            "type" => "required|exists:partenaire_types,id"
        ]);

        $p = new Partenaire();
        $p->nom = $request->nom;
        $p->logo_url = $request->logo_url;
        $p->site_web = $request->site_web;
        $p->type = $request->type;
        $p->save();

        return $p;
    }

    public function removePartenaire($id)
    {
        $partenaire = Partenaire::find($id);
        $partenaire->delete();
        return $partenaire;
    }

    public function updatePartenaire(Request $request, $id)
    {
        $request->validate([
            "nom" => "required",
            "logo_url" => "required"
        ]);
        $p = Partenaire::find($id);
        if ($p) {
            $p->nom = $request->nom;
            $p->logo_url = $request->logo_url;
            $p->site_web = $request->site_web ?? $p->site_web;
            $p->save();
            return $p;
        } else {
            return response()->json(["message" => "Partenaire with id $id not found"], 404);
        }
    }


    public function parametre()
    {
        return Param::all();
    }

    public function partenaireTypes()
    {
        return PartenaireType::all();
    }

    public function modePayements()
    {
        
        return ModePayement::all();
    }
}
