<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Partenaire extends Model
{
    use Uuids;
    use HasFactory;
    protected $with = ["type"];

    protected $fillable = ["nom", "logo_url", "site_web"];


    public function type()
    {
        return $this->belongsTo(PartenaireType::class, "type");
    }
}
