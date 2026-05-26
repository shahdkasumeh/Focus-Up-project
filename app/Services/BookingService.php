<?php

namespace App\Services;

use App\Models\Booking;
use App\Models\Room;
use App\Models\Table;
use App\Models\ConsumptionPackage;
use App\Models\LuckyWheel;
use App\Models\Setting;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class BookingService
{
    // =========================================================
    // 1. CREATE BOOKING (Scheduled booking)
    // =========================================================

    public static function createBooking(
    int $userId,
    ?int $tableId,
    ?int $roomId,
    string $scheduledStart,
    string $scheduledEnd
): Booking {

    return DB::transaction(function () use (
        $userId, $tableId, $roomId, $scheduledStart, $scheduledEnd
    ) {


        // =========================
        // Guard: اختيار واحد فقط
        // =========================
        if (!$tableId && !$roomId) {
            throw new \Exception('يجب اختيار طاولة أو غرفة.');
        }

        if ($tableId && $roomId) {
            throw new \Exception('لا يمكن اختيار طاولة وغرفة بنفس الوقت.');
        }

        // =========================
        // Parse time
        // =========================
        $start = Carbon::parse($scheduledStart);
        $end   = Carbon::parse($scheduledEnd);

        if ($start->isPast()) {
            abort(422,'لا يمكن الحجز في وقت ماضٍ.');
        }

        if ($end->lte($start)) {
            throw new \Exception('وقت الانتهاء يجب أن يكون بعد البداية.');
        }
        $start = Carbon::parse($scheduledStart);
$end   = Carbon::parse($scheduledEnd);

// =========================
// 1. منع الحجز في الماضي
// =========================
if ($start->isPast()) {
    throw new \Exception('لا يمكن الحجز في وقت ماضٍ.');
}

// =========================
// 2. منع يوم الجمعة
// =========================
if ($start->dayOfWeek === Carbon::FRIDAY) {
    throw new \Exception('لا يمكن الحجز يوم الجمعة.');
}

// // // =========================
// // // 3. نطاق الوقت (09:00 - 20:00)
// // // =========================
    $open=$start->copy()->setTime(9,0,0);
    $close=$start->copy()->setTime(20,0,0);

// // البداية لازم تكون داخل الدوام
if ($start->lt($open) || $start->gte($close)) {
    throw new \Exception('الحجز مسموح فقط من 09:00 إلى 20:00.');
}

// النهاية لازم تكون داخل الدوام
if ($end->gt($close) || $end->lte($open)) {
    throw new \Exception('وقت انتهاء الحجز يجب أن يكون قبل 20:00.');
}

// // =========================
// // 4. منع أي حجز يمتد خارج الدوام (الأهم)
// // =========================
if ($start->copy()->startOfDay()->addHours(9)->gt($start) ||
    $end->copy()->startOfDay()->addHours(20)->lt($end)) {
    throw new \Exception('لا يمكن أن يمتد الحجز خارج أوقات العمل.');
}


        // =========================
        // User conflict (مهم جداً)
        // =========================
        $userConflict = Booking::where('user_id', $userId)
            ->whereIn('status', ['pending', 'active'])
            ->lockForUpdate()
            ->exists();

        if ($userConflict) {
            throw new \Exception('لديك حجز قائم بالفعل.');
        }

        // =========================
        // TABLE booking
        // =========================
        if ($tableId) {

            // 🔒 Lock resource
            $table = Table::where('id', $tableId)
                ->lockForUpdate()
                ->firstOrFail();

            if (!$table->is_active) {
                throw new \Exception('الطاولة غير متاحة.');
            }

            // 🔥 منع التداخل الزمني
            $tableConflict = Booking::where('table_id', $tableId)
                ->whereIn('status', ['pending', 'active'])
                ->where(function ($q) use ($start, $end) {
                    $q->whereBetween('scheduled_start', [$start, $end])
                    ->orWhereBetween('scheduled_end', [$start, $end])
                    ->orWhere(function ($q) use ($start, $end) {
                        $q->where('scheduled_start', '<=', $start)
                            ->where('scheduled_end', '>=', $end);
                    });
                })
                ->lockForUpdate()
                ->exists();

            if ($tableConflict) {
                throw new \Exception('يوجد حجز متداخل على هذه الطاولة.');
            }
        }

        // =========================
        // ROOM booking
        // =========================
        else {

            $room = Room::where('id', $roomId)
                ->lockForUpdate()
                ->firstOrFail();

            if (!$room->is_active) {
                throw new \Exception('الغرفة غير متاحة.');
            }

            if ($room->type !== 'booking') {
                throw new \Exception('هذه الغرفة لا تقبل الحجز المسبق.');
            }

            // 🔥 منع التداخل الزمني
            $roomConflict = Booking::where('room_id', $roomId)
                ->whereIn('status', ['pending', 'active'])
                ->where(function ($q) use ($start, $end) {
                    $q->whereBetween('scheduled_start', [$start, $end])
                    ->orWhereBetween('scheduled_end', [$start, $end])
                    ->orWhere(function ($q) use ($start, $end) {
                        $q->where('scheduled_start', '<=', $start)
                            ->where('scheduled_end', '>=', $end);
                    });
                })
                ->lockForUpdate()
                ->exists();

            if ($roomConflict) {
                throw new \Exception('يوجد حجز متداخل في هذه الغرفة.');
            }
        }
// =========================
        // Discount (optional)
        // =========================
        $wheel = LuckyWheel::where('user_id', $userId)
            ->where('name', 'discount')
            ->where('is_used', false)
            ->lockForUpdate()
            ->latest()
            ->first();

        $discount = $wheel ? (float) $wheel->value : 0;

        // =========================
        // Create booking
        // =========================
        $booking= Booking::create([
            'user_id'          => $userId,
            'table_id'         => $tableId,
            'room_id'          => $roomId,
            'scheduled_start'  => $start,
            'scheduled_end'    => $end,
            'discount_percent' => $discount,
            'status'           => 'pending',
        ]);
            if ($discount > 0) {
            LuckyWheel::where('user_id', $userId)
                ->where('name', 'discount')
                ->where('is_used', false)
                ->update([
                    'is_used'            => true,
                    'used_in_booking_id' => $booking->id,
                ]);
        }
        return $booking;

    });
}
//     // =========================================================
//     // 3. CHECK IN (QR start for scheduled booking)
//     // =========================================================

   public static function checkIn(
    int $userId,
    ?int $bookingId = null
): Booking {

    return DB::transaction(function () use ($userId, $bookingId) {

        // =====================================================
        // 1. BOOKING مسبق (QR فيه booking_id)
        // =====================================================
        if ($bookingId) {

            $booking = Booking::where('id', $bookingId)
                ->where('user_id', $userId)
                ->lockForUpdate()
                ->firstOrFail();

            if ($booking->status !== 'pending') {
                throw new \Exception('الحجز ليس في حالة انتظار.');
            }

            if (now()->lt($booking->scheduled_start)) {
                throw new \Exception('لم يحن وقت الحجز بعد.');
            }

            $booking->update([
                'status'       => 'active',
                'actual_start' => now(),
            ]);

            if ($booking->table_id) {
                Table::where('id', $booking->table_id)
                    ->update(['is_occupied' => true]);
            }

            if ($booking->room_id) {
                Room::where('id', $booking->room_id)
                    ->update(['is_occupied' => true]);
            }

            return $booking->fresh()->load(['table', 'room']);
        }

        // =====================================================
        // 2. WALK-IN CHECK-IN
        // =====================================================

        $alreadyActive = Booking::where('user_id', $userId)
            ->where('status', 'active')
            ->whereNull('table_id')
            ->whereNull('room_id')
            ->lockForUpdate()
            ->exists();

        if ($alreadyActive) {
            throw new \Exception('لديك جلسة نشطة بالفعل.');
        }

        $wheel = LuckyWheel::where('user_id', $userId)
            ->where('name', 'discount')
            ->where('is_used', false)
            ->lockForUpdate()
            ->first();

        $discount = $wheel ? (float) $wheel->value : 0;

        $booking = Booking::create([
            'user_id'          => $userId,
            'table_id'         => null,
            'room_id'          => null,
            'scheduled_start'  => null,
            'scheduled_end'    => null,
            'actual_start'     => now(),
            'discount_percent' => $discount,
            'status'           => 'active',
        ]);

        if ($discount > 0) {
            LuckyWheel::where('user_id', $userId)
                ->where('name', 'discount')
                ->where('is_used', false)
                ->update([
                    'is_used'            => true,
                    'used_in_booking_id' => $booking->id,
                ]);
        }

        return $booking;
    });
}
public static function checkOut(
    int $userId,
    ?int $bookingId = null
): Booking {

    return DB::transaction(function () use ($userId, $bookingId) {

        // =====================================================
        // 1. BOOKING مسبق (QR)
        // =====================================================
        if ($bookingId) {

            $booking = Booking::where('id', $bookingId)
                ->where('user_id', $userId)
                ->lockForUpdate()
                ->firstOrFail();

            if ($booking->status !== 'active') {
                throw new \Exception('الحجز ليس نشطاً.');
            }

            $start = Carbon::parse($booking->actual_start);
            $end   = now();

            $minutes = $start->diffInMinutes($end);

            if ($minutes < 1) {
                throw new \Exception('جلسة قصيرة جداً.');
            }

            $hours = round($minutes / 60, 2);

            $pricePerHour = self::getPricePerHour($userId);

            $rawPrice = $pricePerHour * $hours;

            $discountPercent = $booking->discount_percent ?? 0;

            $discountAmount = ($rawPrice * $discountPercent) / 100;

            $totalPrice = max(0, $rawPrice - $discountAmount);

            $booking->update([
                'actual_end'      => $end,
                'hours'           => $hours,
                'total_price'     => $totalPrice,
                'discount_amount' => $discountAmount,
                'status'          => 'completed',
            ]);

            if ($booking->table_id) {
                Table::where('id', $booking->table_id)
                    ->update(['is_occupied' => false]);
            }

            if ($booking->room_id) {
                Room::where('id', $booking->room_id)
                    ->update(['is_occupied' => false]);
            }

            self::deductFromSubscription($userId, $hours, $totalPrice);

            return $booking->fresh()->load(['table', 'room']);
        }

        // =====================================================
        // 2. WALK-IN CHECK-OUT
        // =====================================================

        $booking = Booking::where('user_id', $userId)
            ->where('status', 'active')
            ->whereNull('table_id')
            ->whereNull('room_id')
            ->lockForUpdate()
            ->first();

        if (!$booking) {
            throw new \Exception('لا توجد جلسة نشطة.');
        }

        $start = Carbon::parse($booking->actual_start);
        $end   = now();

        $minutes = $start->diffInMinutes($end);

        if ($minutes < 1) {
            throw new \Exception('جلسة قصيرة جداً.');
        }

        $hours = round($minutes / 60, 2);

        $pricePerHour = self::getPricePerHour($userId);

        $rawPrice = $pricePerHour * $hours;

        $discountPercent = $booking->discount_percent ?? 0;

        $discountAmount = ($rawPrice * $discountPercent) / 100;

        $totalPrice = max(0, $rawPrice - $discountAmount);

        $booking->update([
            'actual_end'      => $end,
            'hours'           => $hours,
            'total_price'     => $totalPrice,
            'discount_amount' => $discountAmount,
            'status'          => 'completed',
        ]);

        self::deductFromSubscription($userId, $hours, $totalPrice);

        return $booking->fresh();
    });
}
    // =========================================================
    // 5. CANCEL BOOKING
    // =========================================================

    public static function cancelBooking(int $bookingId, int $userId): Booking
    {
        return DB::transaction(function () use ($bookingId, $userId) {

            $booking = Booking::where('user_id', $userId)
                ->lockForUpdate()
                ->findOrFail($bookingId);

            if ($booking->status !== 'pending') {
                throw new \Exception('لا يمكن الإلغاء.');
            }

            $booking->update(['status' => 'cancelled']);

            self::releasePlace($booking);

            return $booking;
        });
    }

    // =========================================================
    // HELPERS
    // =========================================================

    private static function checkOverlap($tableId, $roomId, $start, $end)
    {
        Booking::where(function ($q) use ($tableId, $roomId) {
                if ($tableId) {
                    $q->where('table_id', $tableId);
                } else {
                    $q->where('room_id', $roomId);
                }
            })
            ->whereIn('status', ['pending', 'active'])
            ->where(function ($q) use ($start, $end) {
                $q->whereBetween('scheduled_start', [$start, $end])
                    ->orWhereBetween('scheduled_end', [$start, $end])
                    ->orWhere(function ($q2) use ($start, $end) {
                    $q2->where('scheduled_start', '<=', $start)
                    ->where('scheduled_end', '>=', $end);
    });
            })
            ->lockForUpdate()
            ->exists();
    }

    private static function checkActivePlace($tableId, $roomId)
    {
        $query = Booking::whereIn('status', ['pending', 'active']);

        if ($tableId) {
            if ($query->where('table_id', $tableId)->lockForUpdate()->exists()) {
                throw new \Exception('المكان مشغول.');
            }
        } else {
            if ($query->where('room_id', $roomId)->lockForUpdate()->exists()) {
                throw new \Exception('المكان مشغول.');
            }
        }
    }

    private static function releasePlace($booking)
    {
        if ($booking->table_id) {
            Table::where('id', $booking->table_id)->update(['is_occupied' => false]);
        }

        if ($booking->room_id) {
            Room::where('id', $booking->room_id)->update(['is_occupied' => false]);
        }
    }

    private static function getPricePerHour(int $userId): float
{
    // أولاً: هل عنده باقة نشطة؟
    $package = ConsumptionPackage::where('user_id', $userId)
        ->where('status', 'active')
        ->where(function ($q) {
            $q->whereNull('expires_at')
            ->orWhere('expires_at', '>', now());
        })
        ->where('remaining_hours', '>', 0)
        ->lockForUpdate()
        ->first();

    if ($package && $package->remaining_hours > 0) {
        // سعر الساعة من الباقة = المبلغ المتبقي ÷ الساعات المتبقية
        return round((float) $package->remaining_price / (float) $package->remaining_hours, 2);
    }

    // ثانياً: السعر العادي من الإعدادات
    return (float) Setting::where('key', 'default_price_per_hour')->value('value') ?? 0;
}

private static function deductFromSubscription(
    int $userId,
    float $hours,
    float $totalPrice
): void {

    $package = ConsumptionPackage::where('user_id', $userId)
        ->where('status', 'active')
        ->where(function ($q) {
            $q->whereNull('expires_at')
                ->orWhere('expires_at', '>', now());
        })
        ->where('remaining_hours', '>', 0)
        ->lockForUpdate()
        ->first();

    if (!$package) {
        return; // لا باقة → لا خصم
    }

    $newHours  = max(0, round((float) $package->remaining_hours - $hours, 2));
    $newAmount = max(0, round((float) $package->remaining_price - $totalPrice, 2));
    $expired   = ($newHours <= 0);

    $package->update([
        'remaining_hours' => $newHours,
        'remaining_price' => $newAmount,
        'status'          => $expired ? 'expired' : 'active',
    ]);
}

    public static function getFullBookingStatus(): array
{
    $status = Booking::selectRaw('status, COUNT(*) as count')
        ->groupBy('status')
        ->pluck('count', 'status');

    $total = Booking::count();

    return [
        'total'     => $total,
        'active'    => $status['active'] ?? 0,
        'completed' => $status['completed'] ?? 0,
        'cancelled' => $status['cancelled'] ?? 0,
        'pending'   => $status['pending'] ?? 0,
        'no_show'   => $status['no_show'] ?? 0,
    ];
}

public static function lastWeekBookingsCount(): int
{
    return Booking::whereBetween('created_at', [
        Carbon::now()->subWeek()->startOfWeek(),
        Carbon::now()->subWeek()->endOfWeek(),
    ])->count();
}

public static function lastWeekRevenue(): float
{
    return (float) Booking::where('status', 'completed')
        ->whereBetween('actual_end', [
            Carbon::now()->subWeek()->startOfWeek(),
            Carbon::now()->subWeek()->endOfWeek(),
        ])
        ->sum('total_price');
}

}
