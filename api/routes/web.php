<?php

use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\NotificationController;

Route::get("", function(){
    return URL::to("/");
});

Route::any("send-sms", function(){
    $a = new NotificationController;
    return $a->sendSMS("Abdou ya rew", "+221770662676");
});