@component('mail::message')
# Message depuis TRANCHEPAY.

@component('mail::panel')
# INFORMATIONS DU CLIENT
- Prénoms et Nom : {{ $full_name }}
- Email : {{ $email }}
- Téléphone : {{ $telephone ?? 'PAS DE NUMÉRO DE TÉLÉPHONE' }}
- SITE WEB : {{ $site ?? 'PAS DE SITE WEB'}}
- Entreprise : {{ $entreprise ?? "PAS D'ENTREPRISE "}}

@endcomponent

{{ $message }}

{{ config('app.name') }}
@endcomponent
