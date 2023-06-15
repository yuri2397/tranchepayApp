<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Retrait extends Model
{
    use Uuids;
    use HasFactory;

    protected $fillable = [
        'montant',
        'date',
        'via',
        'compte_id',
        'description',
    ];

    public function compte()
    {
        return $this->belongsTo(Compte::class);
    }

    public function getMontantAttribute($value)
    {
        return number_format($value, 2, ',', ' ');
    }

    public function setMontantAttribute($value)
    {
        $this->attributes['montant'] = str_replace(' ', '', $value);
    }

    public function getDateAttribute($value)
    {
        return date('d/m/Y', strtotime($value));
    }

    public function setDateAttribute($value)
    {
        $this->attributes['date'] = date('Y-m-d', strtotime($value));
    }

    public function getViaAttribute($value)
    {
        return $value == 'cash' ? 'Espèces' : 'Virement';
    }
}
