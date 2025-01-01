<?php

namespace Database\Seeders;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\Seeder;
use App\Models\User;
class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // User::factory()->count(50)->create();
        \App\Models\User::factory()->create([
            'name'=>'Test1111111111 User',
            'email'=>'haidarhassh@gmail.com',
            'password'=>Hash::make('12345678'),

        ]);

    }
}
