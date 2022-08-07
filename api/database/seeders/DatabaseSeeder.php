<?php

namespace Database\Seeders;

use App\Models\PartenaireType;
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
        // $this->call(RoleSeeder::class);
        // $this->call(AddAdminUser::class);

        $ps = [
            "Santé", "Habitat", "Alimentaire", "Autres", "Musique","Ventes privées"
        ];

        foreach ($ps as $value) {
            $e = new PartenaireType();
            $e->nom = $value;
            $e->code = uniqid();
            $e->save();
        }
        
    }
}
