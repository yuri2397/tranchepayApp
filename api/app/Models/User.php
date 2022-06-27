<?php

namespace App\Models;

use App\Traits\Uuids;
use Laravel\Passport\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use HasRoles;
    use Uuids;
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var string[]
     */
    protected $fillable = ['*'];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array
     */
    protected $casts = [
        'email_verify_at' => 'datetime',
    ];

    public function username()
    {
        return 'username';
    }

    protected $with = ['permissions'];

    public function hasPermission($permission)
    {
        foreach ($this->permissions as $value) {
            if($value->name === $permission){
                return true;
            }
        }
        return false;
    }
}
