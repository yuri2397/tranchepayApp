<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use app\models\User;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        $this->call(LaratrustSeeder::class);
        $this->call(superadminSeeder::class);
    }
}
