<?php

namespace App\Http\Controllers\Api;

use App\Models\Boutique;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Traits\Utils;
use Illuminate\Support\Facades\URL;

class BoutiqueController extends Controller
{
    use Utils;
    private const DEFAULT_PER_PAGE = 10;
    private const DEFAULT_PAGE = 1;
    private const DEFAULT_COLUMNS = ['*'];
    private const DEFAULT_PAGE_NAME = 'data';
    private const DEFAULT_LOGO_PATH = 'boutiques';
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $boutiques = Boutique::with($request->with ?? ['compte']);

        if ($request->has('q')) {
            $boutiques = $boutiques->where('nom', 'like', "%{$request->q}%");
        }

        if ($request->has('commercant_id')) {
            $boutiques = $boutiques->where('commercant_id', $request->commercant_id);
        }

        if ($request->has('per_page')) {
            $boutiques = $boutiques->paginate($request->per_page, $request->columns ?? ['*'], 'page', $request->page_name ?? 'data', $request->page ?? 1);
        } else {
            $boutiques = $boutiques->get();
        }

        return response()->json($boutiques, 200);
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
            'nom' => 'required',
            'addresse' => 'required',
            'telephone' => 'required',
            'commercant_id' => 'required',
        ]);

        $boutique = Boutique::create([
            'nom' => $request->nom,
            'addresse' => $request->addresse,
            'telephone' => formatOnePhone($request->telephone, false),
            'commercant_id' => $request->commercant_id,
        ]);

        if ($request->hasFile('logo')) {
            $boutique->logo = URL::to('/') . '/' . $request->file('logo')->store(self::DEFAULT_LOGO_PATH);
            $boutique->save();
        }

        // create a new compte for the boutique
        $boutique->compte()->create([
            'solde' => 0,
            "boutique_id" => $boutique->id
        ]);

        return response()->json([
            'message' => 'Boutique créée avec succès',
            'boutique' => $boutique
        ], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $boutique = Boutique::with(['compte'])->find($id);

        if ($boutique) {
            return response()->json($boutique, 200);
        }

        return response()->json([
            'message' => 'Boutique introuvable',
        ], 404);
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
        $boutique = Boutique::find($id);

        if ($boutique) {
            $boutique->update([
                'nom' => $request->nom,
                'addresse' => $request->addresse,
                'telephone' => formatOnePhone($request->telephone, false),
                'commercant_id' => $request->commercant_id,
            ]);

            if ($request->hasFile('logo')) {
                $boutique->logo =  URL::to('/') .  '/storage' . $request->file('logo')->store(static::DEFAULT_LOGO_PATH);
                $boutique->save();
            }

            return response()->json([
                'message' => 'Boutique modifiée avec succès',
                'boutique' => $boutique
            ], 200);
        }

        return response()->json([
            'message' => 'Boutique introuvable',
        ], 404);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $boutique = Boutique::find($id);

        if ($boutique) {
            $boutique->delete();
            return response()->json([
                'message' => 'Boutique supprimée avec succès',
            ], 200);
        }

        return response()->json([
            'message' => 'Boutique introuvable',
        ], 404);
    }
}
