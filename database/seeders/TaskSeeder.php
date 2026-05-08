<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class TaskSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('tasks')->insert([

            [
                'title' => 'Study Laravel',
                'description' => 'Study chapter 3 of Laravel',
                'status' => 'pending',
                'due_date' => '2026-05-10',
                'user_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Solve database exercise',
                'description' => 'Solve exercise number 5',
                'status' => 'pending',
                'due_date' => '2026-05-11',
                'user_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Review API',
                'description' => 'Review Laravel API',
                'status' => 'done',
                'due_date' => '2026-05-09',
                'user_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Prepare presentation',
                'description' => 'Prepare presentation for graduation project',
                'status' => 'pending',
                'due_date' => '2026-05-12',
                'user_id' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
