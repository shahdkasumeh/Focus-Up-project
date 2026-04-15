<?php

namespace Database\Seeders;

use App\Models\Room;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RoomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $rooms = [
            [
                'name' => 'Quiet Room',
                'type' => 'quiet',
                'capacity' => 10,
            ],
            [
                'name' => 'Smoking Social Room',
                'type' => 'social_smoking',
                'capacity' => 10,
            ],
            [
                'name' => 'Non-Smoking Social Room',
                'type' => 'social_no_smoking',
                'capacity' => 10,
            ],

            [
                'name' => 'Discussion Room',
                'type' => 'discussion',
                'capacity' => 10,
            ],

            [
                'name' => 'social Room',
                'type' => 'social',
                'capacity' => 50,
            ],

        ];

        foreach ($rooms as $room) {
            Room::create([
                'name' => $room['name'],
                'type' => $room['type'],
                'capacity' => $room['capacity'],
                'is_active' => true,
                'is_occupied' => false,
                'status' => 'active',
            ]);
        }
    }
}

