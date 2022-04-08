@component('mail::message')
TRANCHPAY VOUS A CREE VOTRE COMPTE AVEC LES INFORMATIONS CI-DESSOUS

@component('mail::panel')

- Prénoms et Nom : {{ $full_name }}
- Email : {{ $email }}
- Mot de passe :{{ $password }}
@endcomponent


{{ config('app.name') }}
@endcomponent
