<?php

use App\Models\Client;
use App\Models\Commercant;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\App;
use App\Providers\Services\OrangeSMSService;

if (!function_exists('model_type')) {
    function model_type($model): string
    {
        if ($model == 'commercant') return Commercant::class;

        return Client::class;
    }
}

if (!function_exists('orange')) {
    function orange(): OrangeSMSService
    {
        return App::make(OrangeSMSService::class);
    }
}

if (!function_exists('formatPhones')) {

    function formatPhones(array|string $phones, bool $withPlus = true): array|string
    {
        if (!is_array($phones)) return formatOnePhone($phones, $withPlus);
        $response = [];
        foreach ($phones as $phone) {
            $response[] = formatOnePhone($phone, $withPlus);
        }
        return $response;
    }
}

if (!function_exists('normalizeTelephoneNumber')) {
    function normalizeTelephoneNumber(string $telephone): string
    {
        return str_replace([' ', '.', '-', '(', ')'], '', $telephone);
    }
}

if (!function_exists('formatOnePhone')) {
    function formatOnePhone(string $phone, bool $withPlus = true): string
    {
        $phone = normalizeTelephoneNumber($phone);
        if (!($plus = Str::is('+*', $phone)) && !($zero = Str::is('00*', $phone)) && Str::length($phone) == 9) {
            $phone  = ($withPlus ? '+' : '') . '221' . $phone;
        } else if ($plus && !$withPlus) {
            return Str::remove('+', $phone);
        } else if (($zero ?? false) && !$withPlus) {
            return Str::replaceFirst('00', '', $phone);
        }
        return $phone;
    }
}
