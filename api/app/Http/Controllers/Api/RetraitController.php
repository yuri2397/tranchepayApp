<?php

namespace App\Http\Controllers\Api;

use App\Models\Compte;
use App\Models\Retrait;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class RetraitController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $retraits = Retrait::with($request->with ?? []);

        if ($request->has("compte_id")) {
            $retraits = $retraits->where("compte_id", $request->compte_id);
        }

        if ($request->has("per_page")) {
            return $retraits->paginate($request->per_page, $request->columns ?? ['*'], $request->page_name ?? 'page', $request->page ?? null);
        }

        return $retraits->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            "amount" => "required|numeric",
            "via" => "required|in:wave,om,free",
        ]);

        $compte = Compte::find($request->compte_id);

        if ($compte->solde < $request->amount) {
            return response()->json([
                "message" => "Le solde du compte est insuffisant pour effectuer cette opération"
            ], 400);
        }

        switch ($request->via) {
            case 'wave':
                
                break;

            case 'wave':

                break;

            case 'wave':

                break;

            default:

                break;
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
