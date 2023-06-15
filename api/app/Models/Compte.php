<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Compte extends Model
{
    use Uuids;
    use HasFactory;
    protected $fillable = [
        'solde',
        'boutique_id',
    ];

    public function retraits()
    {
        return $this->hasMany(Retrait::class);
    }

    public function boutique()
    {
        return $this->belongsTo(Boutique::class);
    }

    public function versements()
    {
        return $this->hasMany(Versement::class);
    }
}
