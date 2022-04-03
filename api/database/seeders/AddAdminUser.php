<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Admin;
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
    }
}
