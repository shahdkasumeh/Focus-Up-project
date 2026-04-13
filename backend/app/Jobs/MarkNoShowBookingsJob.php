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
 *
 * الإصلاح: يستهدف فقط الحجوزات التي:
 *   1. status = 'active'          ← تم تفعيلها بالفعل من ActivateDueBookingsJob
 *   2. actual_start IS NULL       ← لم يمسح الطالب QR بعد
 *   3. scheduled_start <= now() - 60 دقيقة  ← مضت ساعة كاملة على وقت الحجز
 *
 * هذا يضمن أن الحجز الجديد الذي حان وقته للتو لن يُلغى،
 * لأنه يحتاج أن يصبح active أولاً (عبر ActivateDueBookingsJob)
 * ثم تمر عليه ساعة بدون مسح QR.
 */
class MarkNoShowBookingsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    private const GRACE_MINUTES = 60;

    public int $tries = 3;

    public function handle(): void
    {
        // الحجوزات التي مضت عليها ساعة بعد scheduled_start بدون مسح QR
        $noShows = Booking::where('status', 'active')
            ->whereNull('actual_start')
            ->where('scheduled_start', '<=', now()->subMinutes(self::GRACE_MINUTES))
            ->get();

        foreach ($noShows as $booking) {
            try {
                DB::transaction(function () use ($booking) {

                    $booking = Booking::lockForUpdate()->find($booking->id);

                    // double-check بعد القفل
                    if (
                        !$booking
                        || $booking->status !== 'active'
                        || $booking->actual_start !== null
                    ) {
                        return;
                    }

                    // atomic update guard
                    $updated = Booking::where('id', $booking->id)
                        ->where('status', 'active')
                        ->whereNull('actual_start')
                        ->update(['status' => 'no_show']);

                    if (!$updated)
                        return;

                    // تحرير الطاولة/الغرفة
                    if ($booking->table_id) {
                        Table::where('id', $booking->table_id)
                            ->where('is_occupied', true)
                            ->update(['is_occupied' => false]);
                    } else {
                        Room::where('id', $booking->room_id)
                            ->where('is_occupied', true)
                            ->update(['is_occupied' => false]);
                    }
                });
            } catch (\Throwable $e) {
                Log::error("MarkNoShowBookingsJob - الحجز #{$booking->id}: " . $e->getMessage());
            }
        }
    }
}
