<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Admin;
use App\Models\EtatCommande;
use App\Models\Param;
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
        $user->telephone = "33000000";
        $user->password = Hash::make("password");
        $user->save();

        $permissions = Permission::all();

        $user->givePermissionTo($permissions);

        $param = new Param();
        $param->cle = "access_token";
        $param->value = "first";
        $param->save();

        $param2 = new Param();
        $param2->cle = "om_public_key";
        $param2->value = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtZzGVQjEGJ97sFxPmuZ2sUX0F9UTmOY0EEcehsURFyv5u1pGV4/y9P9f0OmTeBjPslVKtF/rqQUsHpqdx0uU/pRFxmHft+phuu+9MCP/hmbFbyJNaF/EeD0A4Nx1j72AWyvctS7z1Xjfio+cuqS5szZ4iOJ1RO3K1gg91CrpxOOoHnQC7PsZ332wbsa/PnBJ5uDBDhA8szpw/OnBKXxxnluKGuD7wse3VH9T1j2yaJWflZlyEKJi6ftRj2+DV/3lA/0ggehOpVN+Px9MYTolGgriK7BZ0Lr4wsVz+hdls+EXJn8beIRkkmtyhF43R9ABbkUfMCoCEnAUSEdLVSwfrwIDAQAB";
        $param2->save();

        $param3 = new Param();
        $param3->cle = "max_pay";
        $param3->value = 10000;
        $param3->save();



        $etat_commandes = [
            "append", "finish","load"
        ];

        foreach ($etat_commandes as $value) {
            $e= new EtatCommande();
            $e->name = $value;
            $e->save();
        }
    }
}
