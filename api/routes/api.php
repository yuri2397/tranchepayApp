<?php

use App\Models\User;
use App\Models\EtatCommande;
use App\Models\ModePayement;
use Illuminate\Http\Request;
use App\Http\Controllers\PayementIPN;
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
use App\Http\Controllers\Api\PartenaireController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\VersementController;

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
    Route::get('/check', [AuthController::class, 'check', 'cors']);
    Route::post('/otp/request', [AuthController::class, 'sendOtp']);
    Route::post('/otp/verify', [AuthController::class, 'verifyOtp']);
    Route::post('/register/client', [ClientController::class, 'store']);
    // Route::post('/register/vendor', [ClientController::class, 'store']);

    Route::get("amc/{telephone}/{token}", [AuthController::class, 'activerCompte'])->name("verifier_telephone");
    Route::post('register-client', [AuthController::class, 'registerClient']);
    Route::post('register-commercant', [AuthController::class, 'registerCommercant']);
    Route::post('set-client-pin', [AuthController::class, 'setCodePin']);
    Route::put("update-phone-number", [AuthController::class, 'updatePhone'])->middleware("auth:api");
    Route::put("update-password", [AuthController::class, 'updatePassword'])->middleware("auth:api");
    Route::put("update-fcm-token", [AuthController::class, 'updateFcmToken'])->middleware("auth:api");
    Route::get('permissions', [AuthController::class, 'listPermissions']);
    Route::put('new-pin', [AuthController::class, 'newClientPin'])->middleware("auth:api");
    Route::post('check-password', [AuthController::class, 'ckeckPassword'])->middleware("auth:api");
});


/**
 * COMMERCANT
 */

Route::prefix('commercants')->middleware(['auth:api', 'cors'])->group(function () {

    Route::get('/profile', [CommercantController::class, 'profile']);
    Route::get('/dashboard', [CommercantController::class, 'dashboard']);
    Route::get('/ventes', [CommercantController::class, 'ventes']);
    Route::get('/solde', [CommercantController::class, 'solde']);
    Route::post('retrait', [CommercantController::class, 'retrait']);
    Route::post('new-user', [AuthController::class, 'addCommercantUsers']);
    Route::delete('remove-user/{id}', [AuthController::class, 'removeCommercantUsers']);
    Route::put('update-user/{id}', [AuthController::class, 'updateCommercantUsers']);
    Route::get('users', [CommercantController::class, 'users']);
    Route::post("new-commande", [CommercantController::class, "createCommande"]);
    Route::get('search-client/{telephone}', [ClientController::class, 'search']);


    Route::get('/', [CommercantController::class, 'index']);
    Route::get('/{id}', [CommercantController::class, 'show']);
    Route::post('/', [CommercantController::class, 'store']);
    Route::put('/{id}', [CommercantController::class, 'update']);
    Route::delete('/{id}', [CommercantController::class, 'destroy']);
});


/**
 * CLIENT
 */


Route::prefix('client')->middleware(['auth:api', 'cors'])->group(function () {

    Route::post('/', [ClientController::class, 'store']);
    Route::put('/{id}', [ClientController::class, 'update']);
    Route::delete('/{id}', [ClientController::class, 'destroy']);
    Route::get('/', [ClientController::class, 'index']);


    Route::get('profile', [ClientController::class, 'profile']);
    Route::get('solde', [ClientController::class, 'solde']);
    Route::get('commandes', [ClientController::class, "commandes"]);
    Route::get('commandes/{id}/details', [CommandeController::class, "show"]);
    Route::get('versements', [ClientController::class, "versements"]);
    Route::get('versements/{id}/details', [VersementController::class, "show"]);
    Route::post('do-versement', [ClientController::class, "effectuerVersement"])->middleware('throttle:5,1');
    Route::post('deplafonnement', [DeplafonnementController::class, 'store']);
    Route::get('paddings', [ClientController::class, 'paddings']);
    Route::get('search', [ClientController::class, 'search']);
    Route::post('paddings/confirme/{id}', [ClientController::class, 'confirmePaddings']);
});


Route::prefix('payments')->middleware(['auth:api', 'cors'])->group(function () {
    Route::post('wave', [PaymentController::class, 'wave']);
    Route::post('om', [PaymentController::class, 'om']);
    Route::post('free', [PaymentController::class, 'free']);
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
Route::prefix('commandes')
    ->middleware(['auth:api', 'cors'])
    ->apiResource('commandes', CommandeController::class);

Route::prefix('parteners')
    ->middleware(['auth:api', 'cors'])
    ->apiResource('parteners', PartenaireController::class);






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
