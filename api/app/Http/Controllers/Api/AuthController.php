<?php

namespace App\Http\Controllers\Api;


use App\Models\User;
use App\Traits\Utils;
use App\Models\Client;
use App\Models\Boutique;
use App\Models\Commercant;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\PasswordResets;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use App\Models\Compte;
use App\Traits\Notification;
use App\Models\Admin;
use App\Models\BoutiqueHasUser;
use Spatie\Permission\Models\Permission;

class AuthController extends Controller
{
    use Utils, Notification;

    public function login(Request $request)
    {
        $this->validate($request, [
            "username" => 'required',
            "password" => "required"
        ]);

        $user = User::whereUsername($request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                "message" => "Nom d'utilisateur ou mot passe incorrect."
            ], 422);
        } else if ($this->isCommercant($user) && $user->email_verify_at == null) {
            return response()->json([
                "message" => "Votre compte n'est toujours activé. Votre demande et toujours en cours d'étude."
            ], 401);
        }
        $auth = $this->getUserInfo($user);

        return response()->json([
            "token" => $user->createToken($request->device_name),
            "user" => $user,
            'permissions' => $user->permissions,
            "data" => $auth,
            "model_type" => $user->model_type
        ], 200);
    }



    public function registerClient(Request $request)
    {
        $this->validate($request, [
            'prenoms' => 'required|string',
            'nom' => 'required|string',
            'telephone' => 'required|unique:users,username|unique:clients,telephone',
        ]);

        try {
            $password = Str::random(6);
            $client = new Client;
            $client->prenoms = $request->prenoms;
            $client->nom = $request->nom;
            $client->telephone = $request->telephone;
            $client->save();

            $user = new User;
            $user->username = $client->telephone;
            $user->password = bcrypt($password);
            $user->model_type = "Client";
            $user->model = $client->id;
            $user->save();
            // ADD TOKEN
            $token = random_int(100000, 999999);
            $resets = new PasswordResets;
            $resets->email = $request->telephone;
            $resets->token = $token;
            $resets->save();

            $message = "BIENVENUE SUR TRANCHE PAY.\nVotre compte client a été crée. Merci d'utiliser ce code pour activer votre compte.\nCODE D'ACTIVATION: $token.\nTRANCHEPAY";
            $this->sendSMS($message, '+221' . $client->telephone);

            return response()->json($client, 201);
        } catch (\Throwable $th) {
            return response()->json([
                'message' => $th
            ], 500);
        }
    }

    public function setCodePin(Request $request)
    {
        $this->validate($request, [
            "token" => "required|exists:password_resets,token",
            "telephone" => "required|exists:password_resets,email",
            "pin" => "required|min:4|max:4|string"
        ]);

        $user = User::whereUsername($request->telephone)->first();
        $user->password = Hash::make($request->pin);
        $user->email_verify_at = now();
        $user->save();
        PasswordResets::whereToken($request->token)->delete();
        return $user;
    }

    public function registerCommercant(Request $request)
    {
        $this->validate($request, [
            "prenoms" => "required",
            "nom" => "required",
            "email" => "required|email|unique:users,email",
            "telephone" => 'required|unique:users,username',
            "adresse" => "required",
            "boutique" => "required|unique:boutiques,nom",
            "password" => "required|min:4"
        ]);

        try {
            DB::beginTransaction();
            $commercant = new Commercant;
            $commercant->prenoms = $request->prenoms;
            $commercant->nom = $request->nom;
            $commercant->telephone = $request->telephone;
            $commercant->adresse = $request->adresse;
            $commercant->save();

            $user = new User;
            $user->username = $request->telephone;
            $user->email = $request->email;
            $user->password = bcrypt($request->password);
            $user->model = $commercant->id;
            $user->model_type = "Commercant";
            $user->save();

            $boutique = new Boutique;
            $boutique->nom = $request->boutique;
            $boutique->addresse = $request->adresse;
            $boutique->commercant_id = $commercant->id;
            $boutique->save();

            $compte = new Compte;
            $compte->boutique_id = $boutique->id;
            $compte->solde = 0;
            $compte->save();

            $permissions = Permission::whereGuardName("api")->get();
            $user->givePermissionTo($permissions);

            // SEND MESSAGE
            $message = "BIENVENUE SUR TRANCHE PAY.\nVotre compte a été bien crée. Votre compte sera activé après vérification.\nMERCI POUR VOTRE CONFIANCE.";
            $this->sendSMS($message, '+221' . $commercant->telephone);
            DB::commit();
            return Commercant::with('boutique')->find($commercant->id);
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }

    public function activerCompte($telephone, $token)
    {
        $resets = PasswordResets::whereEmail($telephone)->whereToken($token)->first();

        if ($resets) {
            $user = User::whereUsername($telephone)->first();
            $user->email_verify_at = now();
            $user->save();
            DB::table('password_resets')->where('email', '=', $resets->email)->delete();
            return $this->redirect('https://tranchepay.com/auth', 302);
        } else {
            return $this->redirect('https://tranchepay.com/unauthorization', 302);
        }
    }

    public function newClientPin(Request $request)
    {
        $this->validate($request, [
            "current_pin" => "required",
            "pin" => "required",
        ]);
        $user = $this->currentUser();
        if (Hash::check($request->current_pin, $user->password)) {
            $user->password = Hash::make($request->pin);
            $user->save();
            $info = $this->getUserInfo($user);
            $message = "Bonjour, " . $info->prenoms . "\nVotre code pin sur tranchepay a été changé. Merci de vous connecter avec le nouveau code pin.\n Nouveau code pin: " . $request->pin . "\n\nTRANCHEPAY.";

            $this->sendSMS($message, "+221" . $info->telephone);
            return response()->json([
                "message" => "Votre mot de passe est modifié avec succès."
            ], 200);
        } else {
            return response()->json([
                "message" => "Votre code pin est incorrecte."
            ], 422);
        }
    }

    public function ckeckPassword(Request $request)
    {
        $this->validate($request, [
            "password" => "required"
        ]);
        $client = $this->currentUser();
        if (Hash::check($request->password, $client->password)) {
            return response()->json([
                "message" => "Votre code pin est correcte."
            ], 200);
        } else {
            return response()->json([
                "message" => "Votre code pin est incorrecte."
            ], 422);
        }
    }

    public function addCommercantUsers(Request $request)
    {
        $request->validate([
            "telephone" => "required|unique:commercants,telephone",
            "prenoms" => "required",
            "nom" => "required",
            "permissions" => "required|array"
        ]);
        $proprietaire = $this->authCommercant();

        try {
            DB::beginTransaction();
            $commercant = new Commercant;
            $commercant->prenoms = $request->prenoms;
            $commercant->nom = $request->nom;
            $commercant->telephone = $request->telephone;
            $commercant->adresse = $request->adresse;
            $commercant->save();

            $user = new User;
            $password = "trachepay" . random_int(10, 99);
            $user->username = $request->telephone;
            $user->email = $request->email;
            $user->password = bcrypt($password);
            $user->model = $commercant->id;
            $user->model_type = "Commercant";
            $user->save();

            $compte = new BoutiqueHasUser();
            $compte->user_id = $user->id;
            $compte->boutique_id = $proprietaire->boutique->id;
            $compte->save();

            $user->givePermissionTo($request->permissions);

            // SEND MESSAGE
            $message = "BIENVENUE SUR TRANCHE PAY.\nLa boutique " . $proprietaire->boutique->nom . " a crée un compte utilisateur pour vous. Vos identifiants de connexion sont: \nTél: " . $user->username . "\nMot de passe: " . $password."\nhttps://tranchepay.com/auth/login";
            $this->sendSMS($message, '+221' . $commercant->telephone);
            DB::commit();
            return Commercant::with('boutique')->find($commercant->id);
        } catch (\Throwable $th) {
            DB::rollBack();
            throw $th;
        }
    }
}
