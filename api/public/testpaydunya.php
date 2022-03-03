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
\Paydunya\Checkout\Store::setWebsiteUrl("http://www.tranchpay.com");
\Paydunya\Checkout\Store::setLogoUrl("http://www.tranchpay.com/logo.png");


// Cas d'une installation via Composer
\Paydunya\Checkout\Store::setCancelUrl("http://www.tranchpay.com/client/annulerpayment"); //A FAIRE ROUTE D'ANNULATION DE PAYMENT  APRES PAYMENT
//$invoice->setCancelUrl("http://magasin-le-choco.com/client/annulerpayment");             //Meme chose que enhaut
//3 - CONFIGURATION DE L'IPN (INSTANT PAYMENT NOTIFICATION)



//PouR La CrEAtIoN De lA FactuRE
$invoice->setCallbackUrl("http://www.tranchpay.com/client/facturepayement");       //A FAIRE URL APRES PAYMENT
$invoice = new \Paydunya\Checkout\CheckoutInvoice();                        //Dans le fichier du code source qui doit effectuer l'action procédez 
                                                                            //ainsi si vous souhaitez rediriger vos clients vers notre site Web afin qu'il puisse achever le processus de paiement:


//A insérer dans le fichier du code source qui doit effectuer l'action
/* L'ajout d'éléments à votre facture est très basique.
Les paramètres attendus sont nom du produit, la quantité, le prix unitaire,
le prix total et une description optionelle. */
$invoice->addItem("Chaussures Croco", 3, 10000, 30000, "Chaussures faites en peau de crocrodile authentique qui chasse la pauvreté");
$invoice->addItem("Chemise Glacée", 1, 5000, 5000);
$invoice->setDescription("Optional Description");                             //description facultatif
$invoice->setTotalAmount(42300);                                              //Le montant total total a facturer le client 

//A insérer dans le fichier du code source qui doit effectuer l'action// Les paramètres sont l'intitulé de la taxe et le montant de la taxe.
$invoice->addTax("TVA (18%)", 6300);
$invoice->addTax("Livraison", 1000);

//A insérer dans le fichier du code source qui doit effectuer l'action

// Les données personnalisées vous permettent d'ajouter des données supplémentaires à vos informations de facture
// que pourrez récupérer plus tard à l'aide de notre action de callback Confirm
$invoice->addCustomData("categorie", "Jeu concours");
$invoice->addCustomData("periode", "Noël 2015");
$invoice->addCustomData("numero_gagnant", 5);
$invoice->addCustomData("prix","Bon de réduction de 50%");
# Ajout des moyens de paiement de manière individuelle
$invoice->addChannel('wari');
$invoice->addChannel('card');
# Ajout de plusieurs moyens de paiement à la fois
$invoice->addChannels(['card', 'jonijoni-senegal', 'orange-money-senegal']);
//A insérer dans le fichier du code source qui doit effectuer l'action
// Le code suivant décrit comment créer une facture de paiement au niveau de nos serveurs,
// rediriger ensuite le client vers la page de paiement
// et afficher ensuite son reçu de paiement en cas de succès.
if($invoice->create()) {
    header("Location: ".$invoice->getInvoiceUrl());
}else{
    echo $invoice->response_text;
}


    array (
    'data' => 
        array (
        'response_code' => '00',
        'response_text' => 'Transaction Found',
        'hash' => '8c6666a27fe5daeb76dae6abc7308a557dca5be1bda85dfe5d81fa330cdc0bc3c4b37765fe5d2cc36aa2ba0f9284226a80f5488d14740fa70769d6079a179406',
        'invoice' => 
            array (
            'token' => 'test_jkEdPY8SuG',
            'items' => 
                array (
                'item_0' => 
                    array (
                    'name' => 'Chaussures Croco',
                    'quantity' => '3',
                    'unit_price' => '10000',
                    'total_price' => '30000',
                    'description' => 'Chaussures faites en peau de crocrodile authentique qui chasse la pauvreté',
                ),
                'item_1' => 
                    array (
                    'name' => 'Chemise Glacée',
                    'quantity' => '1',
                    'unit_price' => '5000',
                    'total_price' => '5000',
                    'description' => '',
                ),
            ),
            'taxes' => 
                array (
                'tax_0' => 
                    array (
                    'name' => 'TVA (18%)',
                    'amount' => '6300',
                ),
                'tax_1' => 
                    array (
                    'name' => 'Livraison',
                    'amount' => '1000',
                ),
        ),
        'token'=>'test_Jh2T8skw1j',
        'total_amount' => '42300',
        'description' => 'Paiement de 42300 FCFA pour article(s) achetés sur Magasin le Choco',
        ),
        'custom_data' => 
            array (
            'categorie' => 'Jeu concours',
            'periode' => 'Noël 2015',
            'numero_gagnant' => '5',
            'prix' => 'Bon de réduction de 50%',
            ),
        'actions' => 
            array (
            'cancel_url' => 'http://www.tranchpay.com/annulerpayement.aspx',          //A FAIRE URL APRES ANNULATION PAYMENT
            'callback_url' => 'www.tranchpay.com/facturepayement.aspx',               //A FAIRE URL APRES PAYMENT
            'return_url' => 'http://www.tranchpay.com/retourpayement.aspx',           //A FAIRE URL APRES VOULOIR RETOUR EN ARRIERE PAYMENT
            ),
        'mode' => 'test',
        'status' => 'completed',
        'customer' => 
            array (
            'name' => 'Alioune Faye',
            'phone' => '774563209',
            'email' => 'aliounefaye@gmail.com',
            ),
        'receipt_url' => 'https://paydunya.com/sandbox-checkout/receipt/pdf/test_jkEdPY8SuG.pdf',
        ),
    )  ;

    //5 - RÉCUPÉRATION DU STATUT DU PAIEMENT
    $status = $_POST['data']['status'];
    //6 - RÉCUPÉRATION DU MONTANT TOTAL DU PAIEMENT
    $amount = $_POST['data']['invoice']['total_amount'];
    //7 - RÉCUPÉRATION DU HASH
    $hash = $_POST['data']['hash'];

    //8 - EXEMPLE DE CODE DE VÉRIFICATION IPN
    try {
    //Prenez votre MasterKey, hashez la et comparez le résultat au hash reçu par IPN
    if($_POST['data']['hash'] === hash('sha512', "emDzaHBl-dcXF-SZc3-SRci-j3WLjKPGN6cT")) {

        if ($_POST['data']['status'] == "completed") {
            //Faites vos traitements backoffice ici...
        }

        } else {
            die("Cette requête n'a pas été émise par PayDunya");
        }
    } catch(Exception $e) {
        die();
    }

//A insérer dans le fichier du code source qui doit effectuer l'action

// PayDunya rajoutera automatiquement le token de la facture sous forme de QUERYSTRING "token"
// si vous avez configuré un "return_url" ou "cancel_url".
// Récupérez donc le token en pur PHP via $_GET['token']
$token = $_GET['token'];

$invoice = new \Paydunya\Checkout\CheckoutInvoice();
if ($invoice->confirm($token)) {

  // Récupérer le statut du paiement
  // Le statut du paiement peut être soit completed, pending, cancelled
  echo $invoice->getStatus();

  // Vous pouvez récupérer le nom, l'adresse email et le
  // numéro de téléphone du client en utilisant
  // les méthodes suivantes
  echo $invoice->getCustomerInfo('name');
  echo $invoice->getCustomerInfo('email');
  echo $invoice->getCustomerInfo('phone');

  // Les méthodes qui suivent seront disponibles si et
  // seulement si le statut du paiement est égal à "completed".

  // Récupérer l'URL du reçu PDF électronique pour téléchargement
  echo $invoice->getReceiptUrl();

  // Récupérer n'importe laquelle des données personnalisées que
  // vous avez eu à rajouter précédemment à la facture.
  // Merci de vous assurer à utiliser les mêmes clés que celles utilisées
  // lors de la configuration.
  echo $invoice->getCustomData("categorie");
  echo $invoice->getCustomData("periode");
  echo $invoice->getCustomData("numero_gagant");
  echo $invoice->getCustomData("prix");

  // Vous pouvez aussi récupérer le montant total spécifié précédemment
  echo $invoice->getTotalAmount();

}else{
  echo $invoice->getStatus();
  echo $invoice->response_text;
  echo $invoice->response_code;
}