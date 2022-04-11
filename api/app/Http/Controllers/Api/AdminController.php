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
        return Commercant::with(['boutique', 'boutique.commandes'])->get();
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
        return Commande::limit(20)->where("etat_commande_id", 2)->get();
    }

    public function finalCommandes()
    {
        return Commande::limit(20)->where("etat_commande_id", 3)->get();
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
        }
        catch (\Throwable $th) {
            return response()->json([
                'message' => $th
            ], 500);
        }

    }


    public function ShowAdminById($id)
    {
        return Admin::Where('id',$id)->first();
    }

    public function ShowMissingPermission(Request $request)
    {

       $permissions= (array)$request->permissions;

        $permission=Permission::all();

        foreach ($permission as $p) {

            return Permission::Where($p->name,'!=',$permissions[0]->name)->get();


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

        $admin=$request->all();
        Admin::find($id)->update($admin);
    }

}
