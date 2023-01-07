<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Commande;
use App\Http\Controllers\Controller;

class CommandeController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     */
    public function index(Request $request)
    {
        $commandes = Commande::with($request->with ?? []);

        if ($request->has('search')) {
            $commandes->where('numero', 'like', "%{$request->search}%");
        }

        if ($request->has('boutique_id')) {
            $commandes->where('boutique_id', $request->boutique_id);
        }

        if ($request->has('client_id')) {
            $commandes->where('client_id', $request->client_id);
        }
        
        if ($request->has('per_page')) {
            return $commandes->paginate($request->per_page ?? 15, $request->columns ?? ['*'], $request->page_name ?? 'page', $request->current_page ?? 1);
        }

        return $commandes->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     */
    public function store(Request $request)
    {
        $request->validate([
            'boutique_id' => 'required',
            'client_id' => 'required',
            'montant' => 'required',
            'products' => 'required|array',
            'products.*.nom' => 'required',
            'products.*.prix_unitaire' => 'required',
            'products.*.quantite' => 'required',
            'interet' => 'required',
            'nb_products' => 'required',
            'nb_tranche' => 'required',
            'commission' => 'required',
            'etat_commande_id' => 'required',
         ]);

        $commande = Commande::create($request->all());

        $commande->produits()->createMany($request->products);

        return $commande;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     */
    public function show(Request $request, $id)
    {
        return Commande::with($request->with ?? [])->find($id);
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
        $request->validate([
            'boutique_id' => 'required',
            'client_id' => 'required',
            'montant' => 'required',
            'products' => 'required|array',
            'products.*.nom' => 'required',
            'products.*.prix_unitaire' => 'required',
            'products.*.quantite' => 'required',
            'interet' => 'required',
            'nb_products' => 'required',
            'nb_tranche' => 'required',
            'commission' => 'required',
            'etat_commande_id' => 'required',
        ]);

        $commande = Commande::find($id);

        $commande->update($request->all());

        $commande->produits()->delete();

        $commande->produits()->createMany($request->products);

        return $commande;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $commande = Commande::find($id);

        $commande->produits()->delete();

        $commande->delete();

        return $commande;
    }
}
