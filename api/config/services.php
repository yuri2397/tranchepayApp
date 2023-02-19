<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Third Party Services
    |--------------------------------------------------------------------------
    |
    | This file is for storing the credentials for third party services such
    | as Mailgun, Postmark, AWS and more. This file provides the de facto
    | location for this type of information, allowing packages to have
    | a conventional file to locate the various service credentials.
    |
    */

    'mailgun' => [
        'domain' => env('MAILGUN_DOMAIN'),
        'secret' => env('MAILGUN_SECRET'),
        'endpoint' => env('MAILGUN_ENDPOINT', 'api.mailgun.net'),
    ],

    'postmark' => [
        'token' => env('POSTMARK_TOKEN'),
    ],

    'ses' => [
        'key' => env('AWS_ACCESS_KEY_ID'),
        'secret' => env('AWS_SECRET_ACCESS_KEY'),
        'region' => env('AWS_DEFAULT_REGION', 'us-east-1'),
    ],
   
    'orange' => [
        'client_id' => env('ORANGE_CLIENT_ID'),
        'client_secret' => env('ORANGE_CLIENT_SECRET'),
    ],

    'services' => [

        'orange' => [
            'api_url' => env('ORANGE_API_URL'),
            'client_id' => env('ORANGE_CLIENT_ID'),
            'client_secret' => env('ORANGE_CLIENT_SECRET'),
            'authorization_header' => env('ORANGE_AUTHORIZATION_HEADER'),
            'sender_number' => env('ORANGE_SENDER_NUMBER'),
            'sender_name' => env('ORANGE_SENDER_NAME')
        ],
    ]
];
