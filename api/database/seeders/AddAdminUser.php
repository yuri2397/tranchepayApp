<?php

namespace Database\Seeders;

use App\Models\Admin;
use App\Models\Param;
use App\Models\EtatCommande;
use App\Models\ModePayement;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Permission;

class AddAdminUser extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user = new Admin();
        $user->full_name = "Super admin";
        $user->email = "admin@tranchepay.com";
        $user->password = Hash::make("password");
        $user->save();

        $permissions = Permission::all();

        $user->givePermissionTo($permissions);

        $param = new Param();
        $param->cle = "access_token";
        $param->valeur = "first";
        $param->save();


        $param3 = new Param();
        $param3->cle = "max_pay";
        $param3->valeur = 10000;
        $param3->save();



        $etat_commandes = [
            "append", "finish","load"
        ];

        foreach ($etat_commandes as $value) {
            $e= new EtatCommande();
            $e->nom = $value;
            $e->save();
        }

        /**
         * ADD MODE DE PAIEMENT
         */
        $mode = [
            [
                "interet" => "10",
                "label" => "Payement en 3 mois 10%",
                "nb_mois" => "3",
            ],
            [
                "interet" => "7",
                "label" => "Payement en 2 mois 7%",
                "nb_mois" => "2",
            ],
            [
                "interet" => "1",
                "label" => "Payement en 3 mois 1%",
                "nb_mois" => "1",
            ]
        ];
    
        foreach ($mode as $value) {
            $m = new ModePayement;
            $m->interet = $value['interet'];
            $m->label = $value['label'];
            $m->nb_mois = $value['nb_mois'];
            $m->save();
        }
    }
}
