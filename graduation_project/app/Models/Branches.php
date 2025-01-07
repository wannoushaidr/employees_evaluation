<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Branches extends Model
{
    use HasFactory;
    protected $fillable=['name','phone','address','email','company_id','created_at','updated_at'];
}
