<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class BoutiqueHasUser extends Model
{
    use Uuids;
    use HasFactory;
    protected $with = ['boutique'];

    public function boutique()
    {
        return $this->belongsTo(Boutique::class);
    }
}
