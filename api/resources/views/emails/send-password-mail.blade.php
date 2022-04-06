@component('mail::message')
# Message dépuis TRANCHEPAY.

@component('mail::panel')
# INFORMATIONS DU CLIENT
- Prénoms et Nom : {{ $full_name }}
- Email : {{ $email }}

@endcomponent

-votre mot de passe en tant que Administrateur est:{{ $email }}

{{ config('app.name') }}
@endcomponent
