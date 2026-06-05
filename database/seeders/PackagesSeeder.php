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
                'price' => 120000,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 60 ساعة',
                'hours' => 60,
                'price' => 170000,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 80 ساعة',
                'hours' => 80,
                'price' => 220000,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 100 ساعة',
                'hours' => 100,
                'price' => 260000,
                'duration_days' => 30,
                'type' => 'hourly',
            ],
            [
                'name' => 'باقة 150 ساعة',
                'hours' => 150,
                'price' => 360000,
                'duration_days' => 30,
                'type' => 'hourly',
            ],

        ]);
    }
}

