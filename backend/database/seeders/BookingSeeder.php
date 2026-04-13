<?php

namespace Database\Seeders;

use App\Models\Booking;
use App\Models\Room;
use App\Models\Table;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use function Laravel\Prompts\table;

class BookingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = User::first();  // جيب أول مستخدم
        $room = Room::first();  // جيب أول غرفة
        $table = Table::first();  //  أضيفي هذا


        if ($user && $room&& $table) {
            Booking::create([
                'user_id' => $user->id,
                'room_id' => $room->id,
                'booking_date' => now()->toDateString(),
                'scheduled_start' => now(),
                'duration' => '02:00:00',
                'price' => 100,
                'status' => 'inactive',
                'actual_start' => null,
                'actual_end' => null,
            ]);

            $this->command->info('✅ Booking created successfully!');
        } else {
            $this->command->error('❌ No user or room found!');
        }


    }
}
