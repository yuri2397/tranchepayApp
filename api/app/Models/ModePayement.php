<?php

namespace App\Models;

use App\Traits\Uuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ModePayement extends Model
{
    use HasFactory;
    use Uuids;

    public $table = "mode_payement";
}
