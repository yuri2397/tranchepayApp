<?php

namespace App\Http\Controllers\Api;

use App\Traits\Utils;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Models\Deplafonnement;
use Illuminate\Support\Facades\URL;
use App\Http\Controllers\Controller;

class DeplafonnementController extends Controller
{

    use Utils;
    public function isPadding()
    {
        $dep = Deplafonnement::whereClientId(auth()->id())->first();
        if ($dep) {
            return $dep;
        }
        return response()->json(null, Response::HTTP_NO_CONTENT);
    }
    public function index()
    {
        return Deplafonnement::all();
    }

    public function store(Request $request)
    {
        $request->validate([
            "cni" => "required|numeric",
        ]);

        if ($request->hasFile('recto') && $request->hasFile('verso')) {
            $recto = $request->file('recto')->move(storage_path('app/public/images'), $request->file("recto")->getClientOriginalName());
            $verso = $request->file('verso')->move(storage_path('app/public/images'), $request->file("verso")->getClientOriginalName());

            $dep = new Deplafonnement;
            $dep->cni = $request->cni;
            $dep->cni_recto = URL::to("/storage/images") . "/" . $request->file("recto")->getClientOriginalName();
            $dep->cni_verso = URL::to("/storage/images") . "/" . $request->file("verso")->getClientOriginalName();
            $dep->client_id = $this->authClient()->id;
            $dep->save();
            
            return response()->json([
                "messag" => "Votre demande est bien enregistrée.",
                "recto" => $recto,
                "versà" => $verso
            ]);
        } else {
            return response()->json([
                "message" => "Veuillez ajouter votre carte d'identité."
            ], 422);
        }
    }


    public function show(Deplafonnement $deplafonnement)
    {
        return $deplafonnement;
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Deplafonnement  $deplafonnement
     * @return \Illuminate\Http\Response
     */
    public function edit(Deplafonnement $deplafonnement)
    {
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Deplafonnement  $deplafonnement
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Deplafonnement $deplafonnement)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Deplafonnement  $deplafonnement
     * @return \Illuminate\Http\Response
     */
    public function destroy(Deplafonnement $deplafonnement)
    {
        //
    }
}
