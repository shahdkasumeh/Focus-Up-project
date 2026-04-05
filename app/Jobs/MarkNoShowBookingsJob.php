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
 * يبحث عن الحجوزات التي:
 *   - حالتها active
 *   - actual_start = null (لم يمسح QR دخول بعد)
 *   - scheduled_start مضى عليها أكثر من ساعة
 *
 * ويحوّلها إلى no_show ويحرّر الطاولة/الغرفة.
 */
class MarkNoShowBookingsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    // مهلة الانتظار بالدقائق قبل اعتبار الطالب no_show
    private const GRACE_MINUTES = 60;

    public int $tries = 3;

    public function handle(): void
    {
        $noShows = Booking::where('status', 'active')
            ->whereNull('actual_start')
            ->where('scheduled_start', '<=', now()->subMinutes(self::GRACE_MINUTES))
            ->get();

        foreach ($noShows as $booking) {
            try {
                DB::transaction(function () use ($booking) {

                    $booking = Booking::lockForUpdate()->find($booking->id);

                    // تحقق مزدوج بعد القفل
                    if (!$booking
                        || $booking->status !== 'active'
                        || $booking->actual_start !== null) {
                        return;
                    }

                    // Atomic update guard
                    $updated = Booking::where('id', $booking->id)
                        ->where('status', 'active')
                        ->whereNull('actual_start')
                        ->update(['status' => 'no_show']);

                    if (!$updated) return;

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
                Log::error("MarkNoShowBookingsJob - فشل معالجة الحجز #{$booking->id}: " . $e->getMessage());
            }
        }
    }
}
