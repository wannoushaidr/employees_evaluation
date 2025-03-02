<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Points extends Model
{
    use HasFactory;
    protected $fillable=['points_count','description','employee_id','customer_id','created_at','updated_at'];

}
