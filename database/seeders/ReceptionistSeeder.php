<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class ReceptionistSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $receptionist = User::create([
            'full_name' => "receptionist",
            'email' => 'receptionist@system.com',
            'password' => Hash::make('12345678'),
            'phone'=>'0000000000'
        ]);

        $receptionist->assignRole(['receptionist']);
    }
}
