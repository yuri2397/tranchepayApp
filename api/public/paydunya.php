<?php
//1 - CONFIGURATION DE L'API
require('vendor/autoload.php');

//integration des clee d'API
\Paydunya\Setup::setMasterKey("emDzaHBl-dcXF-SZc3-SRci-j3WLjKPGN6cT");
\Paydunya\Setup::setPublicKey("test_public_hpYqnaAIWeFI272yUVSQSmpQhcp");
\Paydunya\Setup::setPrivateKey("test_private_eZGDVac9NxifgG8xFdxKIA1I1b5");
\Paydunya\Setup::setToken("I0MKv3vn4eCG1nB3RBr7");
\Paydunya\Setup::setMode("test"); // Optionnel. Utilisez cette option pour les paiements tests.

//2 - CONFIGURATION DES INFORMATIONS DE VOTRE SERVICE/ACTIVITÉ/ENTREPRISE
\Paydunya\Checkout\Store::setName("TRANCHPAY"); // Seul le nom est requis
\Paydunya\Checkout\Store::setTagline("Payer plusieurs fois");
\Paydunya\Checkout\Store::setPhoneNumber("781456105");
\Paydunya\Checkout\Store::setPostalAddress("Ziguinchor");
\Paydunya\Checkout\Store::setWebsiteUrl("http://127.0.0.1:8000");
\Paydunya\Checkout\Store::setLogoUrl("http://127.0.0.1:8000/logo.png");

$invoice->setCallbackUrl("http://127.0.0.1:8000/resources/views/client/facturepayement.blade.php");       //A FAIRE URL APRES PAYMENT
\Paydunya\Checkout\Store::setCancelUrl("http://127.0.0.1:8000/resources/views/client/annulerpayment.blade.php"); //A FAIRE ROUTE D'ANNULATION DE PAYMENT  APRES PAYMENT
\Paydunya\Checkout\Store::setReturnUrl("http://127.0.0.1:8000/client/retour");



  

































?>