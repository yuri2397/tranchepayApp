<?php

use Illuminate\Support\Facades\URL;
use Illuminate\Support\Facades\Route;

Route::get("", function(){
    return redirect("tranchepay.com");
});