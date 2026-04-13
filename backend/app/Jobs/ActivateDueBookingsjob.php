<?php

namespace App\Jobs;

use App\Models\Booking;
use App\Models\Room;
use App\Models\Table;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ActivateDueBookingsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private const GRACE_MINUTES = 60;

    public int $tries = 3;

    public function handle(): void
    {
        // =========================================================
        // STEP 1: pending → active
        // =========================================================
        $dueBookings = Booking::where('status', 'pending')
            ->where('scheduled_start', '<=', now())
            ->get();

        foreach ($dueBookings as $booking) {
            try {
                DB::transaction(function () use ($booking) {

                    $booking = Booking::lockForUpdate()->find($booking->id);

                    if (!$booking || $booking->status !== 'pending') {
                        return;
                    }

                    $booking->update([
                        'status' => 'active',
                    ]);

                    if ($booking->table_id) {
                        Table::where('id', $booking->table_id)
                            ->update(['is_occupied' => true]);
                    } else {
                        Room::where('id', $booking->room_id)
                            ->update(['is_occupied' => true]);
                    }
                });

            } catch (\Throwable $e) {
                Log::error("Activate - فشل تفعيل الحجز #{$booking->id}: " . $e->getMessage());
            }
        }

        // =========================================================
        // STEP 2: active → no_show (بعد 60 دقيقة بدون check-in)
        // =========================================================
//         $noShows = Booking::where('status', 'active')
//             ->whereNull('actual_start')
//             ->where('scheduled_start', '<=', now()) // فقط الحجوزات التي بدأ وقتها
//             ->get();

        //         foreach ($noShows as $booking) {

        //             // 🔥 أهم سطر (يمنع التحويل المباشر)
//             $diff = $booking->scheduled_start->diffInMinutes(now());

        //             if ($diff < self::GRACE_MINUTES) {
//                 continue;
//             }

        //             try {
//                 DB::transaction(function () use ($booking) {

        //                     $booking = Booking::lockForUpdate()->find($booking->id);

        //                     if (!$booking
//                         || $booking->status !== 'active'
//                         || $booking->actual_start !== null) {
//                         return;
//                     }

        //                     $booking->update(['status' => 'no_show']);

        //                     if ($booking->table_id) {
//                         Table::where('id', $booking->table_id)
//                             ->where('is_occupied', true)
//                             ->update(['is_occupied' => false]);
//                     } else {
//                         Room::where('id', $booking->room_id)
//                             ->where('is_occupied', true)
//                             ->update(['is_occupied' => false]);
//                     }
//                 });

        //             } catch (\Throwable $e) {
//                 Log::error("NoShow - فشل معالجة الحجز #{$booking->id}: " . $e->getMessage());
//             }
//         }
//     }
// }
    }
}
