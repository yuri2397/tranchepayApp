<?php

use App\Models\ModePayement;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;
use App\Http\Controllers\TestController;
use Spatie\Permission\Models\Permission;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\ClientController;
use App\Http\Controllers\Api\SharedController;
use App\Http\Controllers\Api\CommandeController;
use App\Http\Controllers\Api\CommercantController;
use App\Http\Controllers\Api\PermissionsController;
use App\Http\Controllers\Api\DeplafonnementController;
use App\Http\Controllers\Auth\RegisteredUserController;
use App\Http\Controllers\PayementIPN;
use App\Models\EtatCommande;
use App\Models\User;

/**
 * MIXED
 */


Route::post("contact-us", [ClientController::class, "contactUs"]);

/**
 * IPN
 */

Route::post("wave/ipn", [PayementIPN::class, "wave"]);
Route::post("om/ipn", [PayementIPN::class, "orangeMoney"]);
Route::post("free/ipn", [PayementIPN::class, "free"]);

/**
 * AUTHENTICATION
 */

Route::prefix("auth")->group(function () {
    Route::post('login', [AuthController::class, 'login', 'cors'])->name("se_connecter");
    Route::get("amc/{telephone}/{token}", [AuthController::class, 'activerCompte'])->name("verifier_telephone");
    Route::post('register-client', [AuthController::class, 'registerClient']);
    Route::post('register-commercant', [AuthController::class, 'registerCommercant']);
    Route::post('set-client-pin', [AuthController::class, 'setCodePin']);
    Route::get('permissions', [AuthController::class, 'listPermissions']);
    Route::put('new-pin', [AuthController::class, 'newClientPin'])->middleware("auth:api");
    Route::post('check-password', [AuthController::class, 'ckeckPassword'])->middleware("auth:api");
});


/**
 * COMMERCANT
 */

Route::prefix('commercant')->middleware(['auth:api', 'cors'])->group(function () {
    Route::get('profile', [CommercantController::class, 'profile']);
    Route::get('dashboard', [CommercantController::class, 'dashboard']);
    Route::get('ventes', [CommercantController::class, 'ventes']);
    Route::get('solde', [CommercantController::class, 'solde']);
    Route::post('retrait', [CommercantController::class, 'retrait']);
    Route::post('new-user', [AuthController::class, 'addCommercantUsers']);
    Route::delete('remove-user/{id}', [AuthController::class, 'removeCommercantUsers']);
    Route::put('update-user/{id}', [AuthController::class, 'updateCommercantUsers']);
    Route::get('users', [CommercantController::class, 'users']);
    Route::post("new-commande", [CommercantController::class, "createCommande"]);
    Route::get('search-client/{telephone}', [ClientController::class, 'search']);
});


/**
 * CLIENT
 */


Route::prefix('client')->middleware(['auth:api', 'cors'])->group(function () {
    Route::get('profile', [ClientController::class, 'profile']);
    Route::post('create', [RegisteredUserController::class, "create"]);
    Route::get('commandes', [ClientController::class, "commandes"]);
    Route::get('versements', [ClientController::class, "versementsClient"]);
    Route::post('do-versement', [ClientController::class, "effectuerVersement"])->middleware('throttle:5,1');
    Route::post('deplafonnement', [DeplafonnementController::class, 'store']);
    Route::get('paddings', [ClientController::class, 'paddings']);
    Route::get('search', [ClientController::class, 'search']);
    Route::post('paddings/confirme/{id}', [ClientController::class, 'confirmePaddings']);
});


/**
 * SHARED
 */
Route::prefix('shared')->middleware(['auth:api', 'cors'])->group(function () {
    Route::get('partenaires', [SharedController::class, 'partenaires']);
    Route::get('check-padding/{id}', [SharedController::class, 'checkPadding']);
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
Route::prefix("admin")->middleware(['auth:admin', 'cors'])->group(function () {
    Route::post("login", [AdminController::class, "login"])->withoutMiddleware("auth:admin");
    Route::get("logout", [AdminController::class, "logout"]);

    // PARTENAIRES
    Route::get("partenaire", [AdminController::class, "partanaires"]);
    Route::post("partenaire/create", [AdminController::class, "createPartenaire"]);
    Route::post("partenaire/remove/{id}", [AdminController::class, "removePartenaire"]);
    Route::get("partenaire/partenaire-types", [AdminController::class, "partenaireTypes"]);
    Route::post("partenaire/update/{id}", [AdminController::class, "updatePartenaire"]);

    // Parametres
    Route::get("parametres", [AdminController::class, "parametre"]);
    Route::post("parametres/update/{id}", [AdminController::class, "updateParam"]);
    Route::post("parametres/update-interet/{id}", [AdminController::class, "updateModePaiement"]);
    Route::get("/parametres/payements", [AdminController::class, "modePayements"]);


    Route::get('last-commandes', [AdminController::class, "lastCommandes"])->middleware('can:lister commande');
    Route::get('commercants', [AdminController::class, "getCommercants"])->middleware('can:lister commercant');
    Route::get('commercants/{id}', [AdminController::class, "showCommercantById"])->middleware('can:voir commercant');
    Route::get('clients/{id}', [AdminController::class, "ShowClienById"])->middleware('can:voir client');
    Route::get('load-commmandes', [AdminController::class, "progressCommandes"])->middleware('can:lister commande');
    Route::get('commande-client/{id}', [AdminController::class, "findcommandeByClienId"])->middleware('can:voir commande');
    Route::get('final-commandes', [AdminController::class, "finalCommandes"])->middleware('can:lister commande');
    Route::get('commande/{id}', [AdminController::class, "findcommande"])->middleware('can:voir commande');
    Route::get('clients', [AdminController::class, "getClients"])->middleware('can:lister client');
    Route::get('admins', [AdminController::class, "getAdmin"])->middleware('can:lister commande');
    Route::get('commercant-inactif', [AdminController::class, "findCommercantInactif"])->middleware('can:lister commercant');
    Route::post('new-admin', [AdminController::class, "registerAdmin"])->middleware('can:creer utilisateur');
    Route::get('all-permissions', [PermissionsController::class, 'allPermissions'])->middleware('can:voir permissions');
    Route::get('admin/{id}', [AdminController::class, 'ShowAdminById'])->middleware('can:voir utilisateur');
    Route::delete('delete/{id}', [AdminController::class, 'destroy'])->middleware('can:supprimer utilisateur');
    Route::put('edit-admin/{id}', [AdminController::class, 'update']);
    Route::put('desactive/{id}', [AdminController::class, 'DesactiveCompte']);
    Route::put('active/{id}', [AdminController::class, 'ActiveCompte']);
});


Route::get("/artisan", function () {
    // $user = User::whereModelType("Commercant")->first();
    // $user->givePermissionTo(Permission::whereGuardName("api")->get());
    // return User::with("permissions")->whereModelType("Commercant")->first();

    $et = new EtatCommande();
    $et->nom = "cancel";
    $et->save();
    return $et;
});


Route::any("/test", [TestController::class, "index"]);
Route::any("/logs", [TestController::class, "allLogs"]);
