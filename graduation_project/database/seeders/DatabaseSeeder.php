<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        \App\Models\User::factory()->create([
            'name'=>'Test1111111111 User',
            'email'=>'haidar22@gmail.com',
            'password'=>'12345678sss'

        ]);

    }
}
