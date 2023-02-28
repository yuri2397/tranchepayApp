<?php

namespace App\Http\Controllers;

use App\Models\Commande;
use App\Traits\FreePayement;
use App\Traits\OMPayement;
use App\Traits\Utils;
use App\Traits\WavePayement;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    use Utils, WavePayement, OMPayement, FreePayement;
    public function wave(Request $request)
    {
        $request->validate([
            "phone" => 'required',
            "commande_id" => "required|exists:commandes,id",
            "amount" => "required|numeric",
        ]);

        $commande = Commande::find($request->commande_id);
        $restant = $this->restant($commande);

        if ($restant == 0) {
            return response()->json(['message' => 'Vous avez déjà payé la totalité de la commande.'], 422);
        }

        if ($restant < $request->amount) {
            return response()->json([
                "message" => "Il vous reste que $restant FCFA à payer. Merci d'effectuer un versement correcte."
            ], 422);
        }

        $client = $this->getUserInfo(auth()->user());
        $response = $this->createCheckoutSession($request->amount, $client, $commande, 'vm');

        if ($response && $response['padding'] != null) {
            // orange()->sendSMS("Confirmer votre paiement TRANCHEPAY avec wave en utilisant ce lien " . $response['response']['wave_launch_url'], $request->phone);
            return response()->json([
                "padding" => $response["padding"],
                "code" => 201,
                "message" => "Votre verssement est en attente de confirmation.",
                "data" => $response['response'],
            ]);
        }
        return response()->json([
            "message" => "Une erreur est survenu lors que votre opération. Merci de reessayer plus tard."
        ], 503);
    }

    public function om(Request $request)
    {
        $request->validate([
            "phone" => 'required',
            "commande_id" => "required|exists:commandes,id",
            "amount" => "required|numeric",
        ]);

        if( !($phone = $this->isValideOrangeNumber($request->phone))) return response()->json([
            "message" => 'Veuillez saissir un numéro OM correcte'
        ], 422);

        $commande = Commande::find($request->commande_id);
        $restant = $this->restant($commande);

        if ($restant == 0) {
            return response()->json(['message' => 'Vous avez déjà payé la totalité de la commande.'], 422);
        }

        if ($restant < $request->amount) {
            return response()->json([
                "message" => "Il vous reste que $restant FCFA à payer. Merci d'effectuer un versement correcte."
            ], 422);
        }

        $client = $this->getUserInfo(auth()->user());

        $om =$this->requestOMPayement($request->amount, $phone , $client, $commande, 'vm');

        if($om && $om['padding'] == null){
            if(((int)$om['response']['status']) >= 400 && ((int)$om['response']['status']) < 500){
                return response()->json(['message' => $om['response']['detail']], 422);

            }else{
                return response()->json(['message' => 'Une erreur s\'est produite, merci de réessayer plus tard.'], 422);
            }
        }

        return response()->json($om);
    }

    public function free(Request $request)
    {
        $request->validate([
            "phone" => 'required',
            "commande_id" => "required|exists:commandes,id",
            "amount" => "required|numeric",
        ]);

        if( !($phone = $this->isValideFreeNumber($request->phone))) return response()->json([
            "message" => 'Veuillez saissir un numéro OM correcte'
        ], 422);

        $commande = Commande::find($request->commande_id);
        $restant = $this->restant($commande);

        if ($restant == 0) {
            return response()->json(['message' => 'Vous avez déjà payé la totalité de la commande.'], 422);
        }

        if ($restant < $request->amount) {
            return response()->json([
                "message" => "Il vous reste que $restant FCFA à payer. Merci d'effectuer un versement correcte."
            ], 422);
        }

        $client = $this->getUserInfo(auth()->user());
    }
}
