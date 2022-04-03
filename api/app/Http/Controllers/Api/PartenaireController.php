<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Partenaire;
use App\Traits\Utils;

class PartenaireController extends Controller
{
    use Utils;
    /**
     * Display a listing of the resource.
     *
     * @return Partenaire[]
     */
    public function index()
    {
        return Partenaire::all();
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
