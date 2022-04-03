<?php

namespace App\Http\Controllers;

use App\Mail\AbonnementNotConf;
use Carbon\Carbon;
use App\Models\Client;
use App\Utils\PayTech;
use App\Models\Payment;
use App\Models\Profile;
use App\Mail\ManqueDeProfil;
use App\Models\Notification;
use Illuminate\Http\Request;
use App\Models\PayementNotConf;
use App\Models\PayementPending;
use App\Mail\RenoullementSsucces;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use App\Mail\NouveauAbonnementSucces;
use App\Models\PasswordReset;
use App\Utils\Utils;
use Exception;
use App\Mail\EmailConfirmation;

use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Validator;

class ClientController extends Controller
{
    use PayTech, Utils;

    public function home()
    {
        $user = Auth::user();
        $profiles = Profile::whereClientId($user->id)->get();
        return view("client.profile")->with([
            "profiles" => $profiles,
            "user" => $user
        ]);
    }

    public function show($id)
    {
        $profile = Profile::whereHash($id)->first();
        if ($profile == null)
            return back();
        return view('client.show-profile')->with(['profile' => $profile]);
    }

    public function abonnement()
    {
        $profiles_dispo = Profile::whereClientId(null)->get();

        if ($profiles_dispo && count($profiles_dispo) > 0) {
            $user = Client::find(auth()->id());
            if ($user == null) redirect()->route("login");
            $ref = $user->email . '_' . now();

            $customfield = json_encode([
                'email' => $user->email,
                'client_id' => $user->id,
                'amount' => $this->price,
                'ref' => $ref,
            ]);

            $data = [
                'item_price' => $this->price,
                "currency"     => "xof",
                "ref_command" => $ref,
                'item_name' => $this->command_name,
                'command_name' => $this->command_name,
                "success_url"  =>  $this->host . '/pay-success',
                "ipn_url"      =>  $this->host . '/api/pay-ipn',
                "cancel_url"   =>  $this->host . '/pay-cancel',
                'env' => 'prod',
                "custom_field" =>   $customfield,
            ];
            return $this->requestPayment($data, $user);
        } else {
            Mail::to(env('ADMIN_EMAIL'))->send(new ManqueDeProfil());
            toastr()->error("Il n y a pas de compte disponible. Réesayer plus tard.", "Erreur d'abonnement");
            return back();
        }
    }

    public function renouvellement(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "hash" => "required|exists:profiles,hash",
            "nombre_mois" => "required|numeric|min:1|max:12",
        ]);

        if ($validator->fails()) {
            toastr()->error("Vérifier les inforomations saisies.");
            return back();
        }

        $profile = Profile::whereHash($request->hash)->first();

        if ($profile) {
            $user = Client::find(auth()->id());
            if ($user == null) redirect()->route("login");
            $ref = $user->email . '_' . now();

            if ($request->nombre_mois == 1) {
                $amount = $this->price;
            } else {
                $amount = ($this->price * $request->nombre_mois) - ($this->price * $request->nombre_mois * 0.03);
            }

            $customfield = json_encode([
                'email' => $user->email,
                'client_id' => $user->id,
                'months' => $request->nombre_mois,
                'profile_id' => $profile->id,
                'amount' => $amount,
                'ref' => $ref,
            ]);

            $data = [
                'item_price' => $amount,
                "currency"     => "xof",
                "ref_command" => $ref,
                'item_name' => $this->command_name,
                'command_name' => $this->command_name,
                "success_url"  =>  $this->host . '/pay-success',
                "ipn_url"      =>  $this->host . '/api/payement',
                "cancel_url"   =>  $this->host . '/pay-cancel',
                'env' => 'prod',
                "custom_field" =>   $customfield,
            ];
            return $this->requestPayment($data, $user);
        } else {
            toastr()->error("Ce compte n'est plus à vous.", "Erreur de renouvellement");
            Auth::guard('client')->logout();
            return redirect()->route("/login");
        }
    }

    public function ipn(Request $request)
    {
        $api_key_sha256 = $request->api_key_sha256;
        $api_secret_sha256 = $request->api_secret_sha256;

        if (hash('sha256', $this->secret_key) === $api_secret_sha256 && hash('sha256', $this->api_key) === $api_key_sha256) {
            $token = $request->token;
            $pendding = PayementPending::whereToken($token)->first();

            if (($request->type_event === "sale_complete") && $pendding != null) {

                $client_phone = $request->client_phone;
                $via = $request->payment_method;
                $item_price = $request->item_price;
                $custom_field = json_decode($request->custom_field, true);
                $client = Client::find($custom_field['client_id']);
                $dispo = true;
                $now = date(now());

                DB::beginTransaction();

                $profile = Profile::whereClientId(null)->first();
                if ($profile == null) {
                    $notConf = new PayementNotConf();
                    $notConf->amount = $item_price;
                    $notConf->date = $now;
                    $notConf->client_id = $client->id;
                    $notConf->save();
                    try {
                        $dispo = false;
                        //$message = "Bonjour $client->first_name.\n\nVotre abonnement est enregistré avec succès. Votre compte sera activé d'ici 24 heures. Un nouveau message vous sera envoyé dès que votre profile sera disponible.\n\nMerci pour votre confiance.";
                        //$this->sendSMS($client->phone_number, $message);
                        Mail::to($client->email)->send(new AbonnementNotConf($client));
                    } catch (\Throwable $th) {
                        DB::commit();
                    }
                } else {
                    $profile->date_end = Carbon::now()->addMonth();
                    $profile->client_id = $client->id;
                    $profile->save();
                }

                $payment = new Payment();
                $payment->amount = $item_price;
                $payment->date = $now;
                $payment->via = $via;
                $payment->profile_id = $profile != null ? $profile->id : null;
                $payment->client_id = $client->id;
                $payment->phone_number = $client_phone;
                $payment->save();

                $pendding->delete();

                DB::commit();

                try {
                    if ($dispo){
                        //$message = "Bonjour $client->first_name,\n\nVotre nouveau abonnement a été ajouté avec succès.\n\n• Adresse email :". $profile->account->email."\n• Mot de passe : ".$profile->account->password."\n• Code pin : $profile->pin\n• N° du profil : $profile->number\n\n🚫🚫 Toute modification des informations du compte est strictement interdites.🚫🚫";
                        //$this->sendSMS($client->phone_number, $message);
                        Mail::to($client->email)->send(new NouveauAbonnementSucces($client, $profile));
                    }
                } catch (\Throwable $th) {
                    DB::commit();
                }
                return response()->json([], 200);
            }
        } else {
            return response()->json([
                "message" => "La requête ne vient pas de paytech."
            ], 200);
        }
    }

    public function ipnRenouvellement(Request $request)
    {
        $api_key_sha256 = $request->api_key_sha256;
        $api_secret_sha256 = $request->api_secret_sha256;

        if (hash('sha256', $this->secret_key) === $api_secret_sha256 && hash('sha256', $this->api_key) === $api_key_sha256) {
            $token = $request->token;
            $pendding = PayementPending::whereToken($token)->first();

            if (($request->type_event === "sale_complete") && $pendding != null) {

                $client_phone = $request->client_phone;
                $via = $request->payment_method;
                $item_price = $request->item_price;
                $custom_field = json_decode($request->custom_field, true);
                $client = Client::find($custom_field['client_id']);
                $profile = Profile::find($custom_field['profile_id']);
                $months = $custom_field['months'];

                $payment = new Payment();
                $payment->amount = $item_price;
                $payment->date = date(now());
                $payment->via = $via;
                $payment->profile_id = $custom_field['profile_id'];
                $payment->client_id = $custom_field['client_id'];
                $payment->phone_number = $client_phone;
                $payment->save();

                DB::beginTransaction();

                $diff = Carbon::createFromFormat('Y-m-d H:s:i', $profile->date_end)->diffInDays(now()) + 1;

                if ($diff > 0) {
                    $profile->date_end = Carbon::now()->addMonths($months)->addDays($diff);
                } else {
                    $profile->date_end = Carbon::now()->addMonths($months);
                }
                $profile->client_id = $client->id;
                $profile->save();

                $pendding->delete();

                DB::commit();

                try {
                    //$message = "Bonjour $client->first_name.\n\nVotre abonnement a été renouvellé avec succès.\n\n• Adresse email : ".$profile->account->email."\n• Mot de passe : ". $profile->account->password."\n• Code pin : $profile->pin\n• N° du profil : $profile->number.\n\n🚫🚫 Toute modification des informations du compte est strictement interdites.🚫🚫";
                    //$this->sendSMS($client->phone_number, $message);
                    Mail::to($client->email)->send(new RenoullementSsucces($client, $profile));
                } catch (\Throwable $th) {
                    return throw new Exception();
                }
                return response()->json([], 200);
            }
        } else {
            return response()->json([
                "message" => "La requête ne vient pas de paytech."
            ], 403);
        }
    }

    public function confirmationForm($token, $email)
    {
        $datas = PasswordReset::whereEmail($email)->whereToken($token)->first();
        if ($datas) {

            $client = Client::whereEmail($datas->email)->first();
            $client->email_verified_at = date(now());
            $client->save();
            DB::delete('delete from password_resets where email = ? and token = ?', [$email, $token]);
            return view("client.email-verification-success");
        } else {
            return view("errors.email-verification-error");
        }
    }

    public function params()
    {
        $client = Client::find(auth()->id());
        return view("client.params")->with(['client' => $client]);
    }

    public function changerPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            "password" => "required",
            "new_password" => "required|min:6"
        ]);

        if ($validator->fails()) {
            return back()->withErrors([
                'message' => "Donner un mot de passe d'au moins 6 caractères."
            ]);
        }

        $client = Client::find(auth()->id());
        if ($client && Hash::check($request->password, $client->password)) {
            $client->password = bcrypt($request->new_password);
            $client->save();
            toastr()->success("Mot de passe modifier avec succès.", "Notification");
            return back()->withErrors([
                'success' => "mot de passe modifier avec succès."
            ]);
        } else {
            toastr()->success("Le mot de passe saisie est invalide.", "Notification");
            return back()->withErrors([
                'message' => "Le mot de passe courent est invalide."
            ]);
        }
    }
    
    public function resendMail()
    {
        $client = auth()->user();
        Mail::to($client->email)->send(new EmailConfirmation($client));
        toastr()->success("Nous vous avons envoyé un nouveau message.", "Notification");
        return back();
    }
}
