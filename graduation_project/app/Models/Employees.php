<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employees extends Model
{
    use HasFactory;
    protected $fillable=['name','number','active','description','gender','position','image','leader_id','branch_id','created_at','updated_at','user_id','email'];

    public function manager()
    {
        return $this->belongsTo(Employee::class, 'leader_id');
    }

    // Relationship to get the supervisors (if the employee is a manager)
    public function supervisors()
    {
        return $this->hasMany(Employee::class, 'leader_id')->where('position', 'supervisor');
    }

    // Relationship to get the customer service representatives (if the employee is a supervisor)
    public function customerServices()
    {
        return $this->hasMany(Employee::class, 'leader_id')->where('position', 'customer_service');
    }

}
