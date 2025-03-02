<?php

namespace App\Models;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use App\Notifications\NotificatiForCustmoerService;
use App\Models\User;
use App\Models\Employees;


class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable,HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',  
        'image',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */

    protected $appends = ['avatar'];


    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    // public function getAvatarAttribute(){

    //     // return "https://www.gravatar.com/avatar/" . md5(strtolower(trim($this->email)));
    //     // return "https://www.gravatar.com/avatar/" . hash( "sha256", strtolower( trim( $this->email ) ) );
    //     // return "https://www.gravatar.com/avatar/" . hash( "sha256", strtolower( trim( "ss" ) ) );
    //     return 1;
        
    // }

    public function employee()  
{  
    return $this->hasOne(Employees::class, 'user_id', 'id');  
}  

public function getAvatarAttribute()  
{  
    // Check if the user has an associated employee  
    if ($this->employee) {  
        return $this->employee->id; // Return the employee's ID  
    }  

    return null; // or return a default value if no employee is found  
}  

    
}
