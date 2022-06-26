<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BoutiqueHasUser extends Model
{
    use HasFactory;
    protected $with = ['boutique'];

    public function boutique()
    {
        return $this->belongsTo(Boutique::class);
    }
}
