<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Compte extends Model
{
    use Uuids;
    use HasFactory;

    public function retraits()
    {
        return $this->hasMany(Retrait::class);
    }
}
