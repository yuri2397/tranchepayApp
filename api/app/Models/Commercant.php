<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Commercant extends Model
{
    use Uuids;
    use HasFactory;

    public function boutique()
    {
        return $this->hasOne(Boutique::class);
    }

    public function user()
    {
        return $this->morphTo(User::class, 'model_type', 'model');
    }

    public function commandes()
    {
        return $this->hasManyThrough(Commande::class, Boutique::class);
    }

    public function versements()
    {
        return $this->hasManyThrough(Versement::class, Boutique::class);
    }

    public function produits()
    {
        return $this->hasManyThrough(Produit::class, Boutique::class);
    }

    public function clients()
    {
        return $this->hasManyThrough(Client::class, Boutique::class);
    }
}
