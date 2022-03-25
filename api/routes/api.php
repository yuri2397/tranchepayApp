<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\SharedController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CommandeController;
use App\Http\Controllers\Api\ClientController;
use App\Http\Controllers\Api\CommercantController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\Api\DeplafonnementController;
use App\Http\Controllers\Api\AdminController;

/**
 * MIXED
 */

Route::post("contact-us", [ClientController::class, "contactUs"]);

/**
 * IPN
 */

Route::post("client-ipn", [ClientController::class , 'clientIPN']);
Route::get("client-cancel_url", [ClientController::class , 'clientCancelURL']);
Route::get("client-return_url", [ClientController::class , 'clientReturnURL']);
Route::post("fp-ipn", [CommercantController::class, "fpIPN"]);

/**
 * AUTHENTICATION
 */

Route::prefix("auth")->group(function () {
    Route::post('login', [AuthController::class , 'login', 'cors'])->name("se_connecter");
    Route::get("amc/{telephone}/{token}", [AuthController::class , 'activerCompte'])->name("verifier_telephone");
    Route::post('register-client', [AuthController::class , 'registerClient']);
    Route::post('register-commercant', [AuthController::class , 'registerCommercant']);
    Route::post('set-client-pin', [AuthController::class , 'setCodePin']);
    Route::put('new-pin', [AuthController::class, 'newClientPin'])->middleware("auth:api");
    Route::post('check-password', [AuthController::class, 'ckeckPassword'])->middleware("auth:api");
});


/**
 * COMMERCANT
 */

Route::prefix('commercant')->middleware(['auth:api', 'cors'])->group(function () {
    Route::get('profile', [CommercantController::class , 'profile']);
    Route::get('dashboard', [CommercantController::class , 'dashboard']);
    Route::get('ventes', [CommercantController::class , 'ventes']);
    Route::get('solde', [CommercantController::class , 'solde']);
    Route::post('retrait', [CommercantController::class , 'retrait']);
    Route::post("new-commande", [CommercantController::class , "createCommande"]);
    Route::get('search-client/{telephone}', [ClientController::class , 'search']);
});


/**
 * CLIENT
 */


Route::prefix('client')->middleware(['auth:api', 'cors'])->group(function () {
    Route::get('profile', [ClientController::class , 'profile']);
    Route::post('create', [RegisteredUserController::class , "create"]);
    Route::get('commandes', [ClientController::class, "commandes"]);
    Route::get('versements', [ClientController::class, "versementsClient"]);
    Route::post('do-versement', [ClientController::class , "effectuerVersement"]);
    Route::post('deplafonnement', [DeplafonnementController::class, 'store']);
});


/**
 * SHARED
 */
Route::prefix('shared')->middleware(['auth:api', 'cors'])->group(function () {
    Route::get('partenaires', [SharedController::class , 'partenaires']);
    Route::get('mode-paiement/{client}', [SharedController::class, 'modePaiement']);
});


/**
 * Commandes Service
 */
Route::prefix('commande')->middleware(['auth:api', 'cors'])->group(function () {
   Route::get("", [CommandeController::class, 'index']);
   Route::get("show/{id}", [CommandeController::class, 'show']);
});


/**
 * Admin Service
 */
Route::prefix("admin")->middleware(['auth:admin', 'cors'])->group(function (){
    Route::post("login", [AdminController::class, "login"])->withoutMiddleware("auth:admin");
    Route::get('last-commandes', [AdminController::class, "lastCommandes"]);
    Route::get('commercants', [AdminController::class, "getCommercants"]);
    Route::get('commercants/{id}', [AdminController::class, "showCommercantById"]);
    Route::get('client/{id}', [AdminController::class, "ShowClienById"]);
    Route::get('load-commmandes', [AdminController::class, "progressCommandes"]);
    Route::get('final-commandes', [AdminController::class, "finalCommandes"]);
    Route::get('clients', [AdminController::class, "getClients"]);
    Route::get('admins', [AdminController::class, "getAdmin"]);
});

