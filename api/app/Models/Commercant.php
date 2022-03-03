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

    
}
