<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Versement extends Model
{
    use Uuids;
    use HasFactory;

    public function commande()
    {
        return $this->belongsTo(Commande::class);
    }
    
}
