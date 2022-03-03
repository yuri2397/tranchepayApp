<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\user;


class superadminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $user=user::create([
            'prenom' => 'Super',
            'nom' => 'ADMIN',
            'boutique' => '',
            'site' => '',
            'valide' => 1,
            'type' => 'superadmin',
            'email' => '',
            'telephone' => 777777777,
            'password' => bcrypt('7777'),
        ]);
        $user->attachRole('superadmin');
    }
}
