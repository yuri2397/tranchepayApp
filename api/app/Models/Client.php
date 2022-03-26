<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Client extends Model
{
    use Uuids;
    use HasFactory;

    protected $with = ['deplafonnement'];

    public function deplafonnement()
    {
        return $this->hasOne(Deplafonnement::class, "client_id");
    }

    public function commandes()
    {
        return $this->hasMany(Commande::class);
    }
}
