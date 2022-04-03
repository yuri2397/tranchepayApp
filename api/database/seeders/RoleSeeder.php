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
                "guard_name" => "api"
            ],
            [
                "name" => "creer commercant",
                "guard_name" => "api"
            ],
            [
                "name" => "supprimer commercant",
                "guard_name" => "api"
            ],[
                "name" => "modifier commercant",
                "guard_name" => "api"
            ],[
                "name" => "lister commercant",
                "guard_name" => "api"
            ],
            [
                "name" => "creer client",
                "guard_name" => "api"
            ],[
                "name" => "voir client",
                "guard_name" => "api"
            ],[
                "name" => "modifier client",
                "guard_name" => "api"
            ],[
                "name" => "supprimer client",
                "guard_name" => "api"
            ],[
                "name" => "lister client",
                "guard_name" => "api"
            ],
            [
                "name" => "creer commande",
                "guard_name" => "api"
            ],[
                "name" => "voir commande",
                "guard_name" => "api"
            ],[
                "name" => "modifier commande",
                "guard_name" => "api"
            ],[
                "name" => "supprimer commande",
                "guard_name" => "api"
            ],[
                "name" => "lister commande",
                "guard_name" => "api"
            ],[
                "name" => "voir dashboard",
                "guard_name" => "api"
            ],
            [
                "name" => "voir utilisateur",
                "guard_name" => "api"
            ],
            [
                "name" => "modifier utilisateur",
                "guard_name" => "api"
            ],
            [
                "name" => "supprimer utilisateur",
                "guard_name" => "api"
            ],
            [
                "name" => "lister utilisateur",
                "guard_name" => "api"
            ],
            [
                "name" => "creer utilisateur",
                "guard_name" => "api"
            ],
            [
                "name" => "voir permissions",
                "guard_name" => "api"
            ]
        ];

        foreach($permissions as $p){
            Permission::create($p);
        }
    }
}
