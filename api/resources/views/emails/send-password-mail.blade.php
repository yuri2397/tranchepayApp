@component('mail::message')
# Message dépuis TRANCHEPAY.

@component('mail::panel')
# INFORMATIONS DU CLIENT
- Prénoms et Nom : {{ $full_name }}
- Email : {{ $email }}

-votre mot de passe en tant que Administrateur est:{{ $email }}
@endcomponent


{{ config('app.name') }}
@endcomponent
