<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UsersSeeder extends Seeder
{
    public function run(): void
    {
        // Toqa (userid = 1)
        User::create([
            'full_name' => 'Toqa Farhat',
            'email' => 'toqa@example.com',
            'password' => Hash::make('12345678'),
            'phone' => '1111111111'
        ]);

        // Lana (userid = 2)
        User::create([
            'full_name' => 'Lana Alhabbal',
            'email' => 'lana@example.com',
            'password' => Hash::make('12345678'),
            'phone' => '2222222222'
        ]);

        // Raghad (userid = 3)
        User::create([
            'full_name' => 'Raghad',
            'email' => 'Raghad@example.com',
            'password' => Hash::make('12345678'),
            'phone' => '3333333333'
        ]);
    }
}
