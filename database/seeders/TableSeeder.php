<?php

namespace Database\Seeders;

use App\Models\Room;
use App\Models\Table;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class TableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
            $rooms = Room::all();

        foreach ($rooms as $room) {
            for ($i = 1; $i <= 10; $i++) {
                Table::create([
                    'table_num' => $i,
                    'room_id' => $room->id,
                    'is_active' => true,
                    'is_occupied' => false,
                ]);
            }
        }
    }
}


