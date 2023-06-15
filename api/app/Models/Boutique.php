<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Boutique extends Model
{
    use Uuids;
    use HasFactory;
    protected $with = ['compte'];
    protected $fillable = [
        'nom',
        'addresse',
        'telephone',
        'logo',
        'commercant_id',
    ];

    public function commandes()
    {
        return $this->hasMany(Commande::class);
    }

    public function compte()
    {
        return $this->hasOne(Compte::class);
    }

    public function commercant()
    {
        return $this->belongsTo(Commercant::class);
    }

    public function produits()
    {
        return $this->hasMany(Produit::class);
    }

}
