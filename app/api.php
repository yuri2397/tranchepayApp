<?php

use App\Models\Account;
use App\Models\Profile;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ClientController;
use App\Models\Client;
use Carbon\Carbon;
Route::post('/pay-ipn', [ClientController::class, 'ipn']);
Route::post('/payement', [ClientController::class, 'ipnRenouvellement']);

