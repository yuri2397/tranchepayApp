<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Commande extends Model
{
    use Uuids;
    use HasFactory;
    protected $with = ['etatCommande'];

    // generate reference number
    public static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            $model->reference = 'CMD-' . date('Ymd') . '-' . str_pad($model->id, 5, '0', STR_PAD_LEFT);
        });
    }


    public function produits()
    {
        return $this->hasMany(Produit::class);
    }

    public function versements()
    {
        return $this->hasMany(Versement::class);
    }

    public function client()
    {
        return $this->belongsTo(Client::class);
    }

    public function etatCommande()
    {
        return $this->belongsTo(EtatCommande::class, 'etat_commande_id');
    }

    public function boutique()
    {
        return $this->belongsTo(Boutique::class);
    }
}
