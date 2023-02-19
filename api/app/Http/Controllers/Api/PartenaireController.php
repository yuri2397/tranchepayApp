<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Partenaire;
use App\Traits\Utils;

use function PHPUnit\Framework\isEmpty;

class PartenaireController extends Controller
{
    use Utils;
    /**
     * Display a listing of the resource.
     *
     * @return Partenaire[]
     */
    public function index(Request $request)
    {
        $query =  Partenaire::with($request->with ?? []);

        if($request->has("search_query") && !isEmpty($request->search_query)){
            $query->where('nom', 'like', "%{$request->search_query}%");
        }

        if ($request->has('per_page') && $request->per_page) {
            return $query->paginate($request->per_page ?? 15, $request->columns ?? ['*'], $request->page_name ?? 'page', $request->current_page ?? 1);
        }

        return $query->get();
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return Partenaire
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            "nom" => "required",
            "logo" => "required|image"
        ]);

        $p = new Partenaire;

        $p->nom = $request->nom;
        $p->logo_url = $this->uploadImage($request->logo, "partenaire_logo");
        $p->site_web = $request->site_web;

        return $p;
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
