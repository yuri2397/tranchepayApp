@component('mail::message')
# Message dépuis TRANCHEPAY.

@component('mail::panel')
# INFORMATIONS DU CLIENT 
- Prénoms et Nom : {{ $full_name }}
- Email : {{ $email }}
- Téléphone : {{ $telephone ?? 'PAS DE NUMÉRO DE TÉLÉPHONE' }}
@if($ninea)
- SITE WEB : {{ $site }}
- Entreprise : {{ $entreprise }}
@endif

@endcomponent

{{ $message }}

{{ config('app.name') }}
@endcomponent