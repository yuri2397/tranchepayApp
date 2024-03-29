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

    protected $fillables = ['prenoms', 'nom', 'adresse', 'telephone', 'image_path'];

    public function deplafonnement()
    {
        return $this->hasOne(Deplafonnement::class, "client_id");
    }

    public function commandes()
    {
        return $this->hasMany(Commande::class);
    }

    public function user()
    {
        return $this->morphOne(User::class, 'model', 'model_type', 'model');
    }

    public function getFullNameAttribute()
    {
        return $this->prenoms . ' ' . $this->nom;
    }

    // get telephone attribute
    public function getTelephoneAttribute($value)
    {
        return $value ? str_replace(" ", "", $value) : 'Inconnu';
    }

    // set telephone attribute
    public function setTelephoneAttribute($value)
    {
        $this->attributes['telephone'] = $value ? formatOnePhone(str_replace(" ", "", $value)) : null;
    }
    
}
