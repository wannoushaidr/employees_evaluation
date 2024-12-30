<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Branches extends Model
{
    use HasFactory;
    protected $fillable=['name','phone','exit_image','table_image','fit_clothes_image','address','email','company_id','created_at','updated_at'];
}
