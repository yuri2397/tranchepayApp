<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permissions = [
            [
                "name" => "voir commercant",
                "guard_name" => "admin"
            ],
            [
                "name" => "creer commercant",
                "guard_name" => "admin"
            ],
            [
                "name" => "supprimer commercant",
                "guard_name" => "admin"
            ],[
                "name" => "modifier commercant",
                "guard_name" => "admin"
            ],[
                "name" => "lister commercant",
                "guard_name" => "admin"
            ],
            [
                "name" => "creer client",
                "guard_name" => "admin"
            ],[
                "name" => "voir client",
                "guard_name" => "admin"
            ],[
                "name" => "modifier client",
                "guard_name" => "admin"
            ],[
                "name" => "supprimer client",
                "guard_name" => "admin"
            ],[
                "name" => "lister client",
                "guard_name" => "admin"
            ],
            [
                "name" => "creer commande",
                "guard_name" => "admin"
            ],[
                "name" => "voir commande",
                "guard_name" => "admin"
            ],[
                "name" => "modifier commande",
                "guard_name" => "admin"
            ],[
                "name" => "supprimer commande",
                "guard_name" => "admin"
            ],[
                "name" => "lister commande",
                "guard_name" => "admin"
            ],[
                "name" => "voir dashboard",
                "guard_name" => "admin"
            ],
            [
                "name" => "voir utilisateur",
                "guard_name" => "admin"
            ],
            [
                "name" => "modifier utilisateur",
                "guard_name" => "admin"
            ],
            [
                "name" => "supprimer utilisateur",
                "guard_name" => "admin"
            ],
            [
                "name" => "lister utilisateur",
                "guard_name" => "admin"
            ],
            [
                "name" => "creer utilisateur",
                "guard_name" => "admin"
            ],
            [
                "name" => "voir permissions",
                "guard_name" => "admin"
            ],
            [
                "name" => "administrateur",
                "guard_name" => "api"
            ],
            [
                "name" => "vendeur",
                "guard_name" => "api"
            ],
            [
                "name" => "opérateur",
                "guard_name" => "api"
            ]
        ];

        foreach($permissions as $p){
            Permission::create($p);
        }
    }
}
