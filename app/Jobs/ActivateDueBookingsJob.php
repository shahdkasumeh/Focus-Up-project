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

/**
 * يعمل كل دقيقة.
 * يبحث عن الحجوزات التي حان وقتها (scheduled_start <= now)
 * ويغيّر حالتها من pending → active ويضع الطاولة/الغرفة مشغولة.
 */
class ActivateDueBookingsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $tries = 3;

    public function handle(): void
    {
        $dueBookings = Booking::where('status', 'pending')
            ->where('scheduled_start', '<=', now())
            ->get();

        foreach ($dueBookings as $booking) {
            try {
                DB::transaction(function () use ($booking) {

                    // قفل + تحقق أنه لا يزال pending
                    $booking = Booking::lockForUpdate()->find($booking->id);
                    if (!$booking || $booking->status !== 'pending') return;

                    $booking->update(['status' => 'active']);

                    if ($booking->table_id) {
                        Table::where('id', $booking->table_id)
                            ->update(['is_occupied' => true]);
                    } else {
                        Room::where('id', $booking->room_id)
                            ->update(['is_occupied' => true]);
                    }
                });
            } catch (\Throwable $e) {
                Log::error("ActivateDueBookingsJob - فشل تفعيل الحجز #{$booking->id}: " . $e->getMessage());
            }
        }
    }
}
