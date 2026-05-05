<?php

namespace Database\Seeders;
use Illuminate\Support\Facades\DB;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class PackagesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
            
        DB::table('packages')->insert([

            [
                'name' => 'باقة 40 ساعة',
                'hours' => 40,
                'price' => 1200,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 60 ساعة',
                'hours' => 60,
                'price' => 1700,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 80 ساعة',
                'hours' => 80,
                'price' => 2200,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 100 ساعة',
                'hours' => 100,
                'price' => 2600,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 150 ساعة',
                'hours' => 150,
                'price' => 3600,
                'duration_days' => 30,
                'type' => 'hourly',
            ],

        ]);
    }
}

