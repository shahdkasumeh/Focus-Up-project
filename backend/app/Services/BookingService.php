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

        return DB::transaction(function () use ($userId, $tableId, $roomId, $scheduledStart, $scheduledEnd) {

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
            $end = Carbon::parse($scheduledEnd);

            if ($start->isPast()) {
                throw new \Exception('لا يمكن الحجز في وقت ماضٍ.');
            }

            if ($end->lte($start)) {
                throw new \Exception('وقت الانتهاء يجب أن يكون بعد البداية.');
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
            $discount = LuckyWheel::where('user_id', $userId)
                ->where('prize_type', 'discount')
                ->where('is_used', false)
                ->lockForUpdate()
                ->value('discount_percent') ?? 0;

            // =========================
            // Create booking
            // =========================
            return Booking::create([
                'user_id' => $userId,
                'table_id' => $tableId,
                'room_id' => $roomId,
                'scheduled_start' => $start,
                'scheduled_end' => $end,
                'discount_percent' => $discount,
                'status' => 'pending',
            ]);
        });
    }
    // =========================================================
    // 2. WALK-IN (QR direct start)
    // =========================================================

    //     public static function walkIn(int $userId, ?int $tableId, ?int $roomId): Booking
//     {
//         return DB::transaction(function () use ($userId, $tableId, $roomId) {

    //             if (!$tableId && !$roomId) {
//                 throw new \Exception('يجب اختيار طاولة أو غرفة.');
//             }

    //             if ($tableId && $roomId) {
//                 throw new \Exception('لا يمكن اختيار الاثنين.');
//             }
// $userConflict = Booking::where('user_id', $userId)
//                 ->whereIn('status', ['pending', 'active'])
//                 ->lockForUpdate()
//                 ->exists();

    //             if ($userConflict) {
//                 throw new \Exception('لديك حجز نشط.');
//             }

    //             if ($tableId) {

    //                 $place = Table::lockForUpdate()->findOrFail($tableId);

    //                 if (!$place->is_active) {
//                     throw new \Exception('الطاولة غير متاحة.');
//                 }

    //                 $this->checkActivePlace($tableId, null);

    //                 Table::where('id', $tableId)->update(['is_occupied' => true]);

    //             } else {

    //                 $place = Room::lockForUpdate()->findOrFail($roomId);

    //                 if (!$place->is_active) {
//                     throw new \Exception('الغرفة غير متاحة.');
//                 }

    //                 if ($place->type !== 'walk_in') {
//                     throw new \Exception('هذه الغرفة للحجز المسبق فقط.');
//                 }

    //                 $this->checkActivePlace(null, $roomId);

    //                 Room::where('id', $roomId)->update(['is_occupied' => true]);
//             }

    //             $discountPercent = LuckyWheel::where('user_id', $userId)
//                 ->where('prize_type', 'discount')
//                 ->where('is_used', false)
//                 ->lockForUpdate()
//                 ->value('discount_percent') ?? 0;

    //             return Booking::create([
//                 'user_id'          => $userId,
//                 'table_id'         => $tableId,
//                 'room_id'          => $roomId,
//                 'scheduled_start'  => null,
//                 'scheduled_end'    => null,
//                 'actual_start'     => now(),
//                 'discount_percent' => $discountPercent,
//                 'status'           => 'active',
//             ]);
//         });
//     }

    //     // =========================================================
//     // 3. CHECK IN (QR start for scheduled booking)
//     // =========================================================

    public static function checkIn(int $userId): Booking
    {
        return DB::transaction(function () use ($userId) {
            // Guard رئيسي: منع الدخول المكرر بأي شكل
            $alreadyActive = Booking::where('user_id', $userId)
                ->where('status', 'active')
                ->lockForUpdate()
                ->exists();

            if ($alreadyActive) {
                throw new \Exception('الخروج انت مسجل الدخول حاليا QR امسح ');
            }

            // =========================
            // (أ) حجز مسبق pending
            // =========================
            $booking = Booking::where('user_id', $userId)
                ->where('status', 'pending')
                ->whereNull('actual_start')
                ->lockForUpdate()
                ->first();

            if ($booking) {

                if (now()->lt($booking->scheduled_start)) {
                    $startsAt = Carbon::parse($booking->scheduled_start)->format('H:i');
                    throw new \Exception("لم يحن وقت حجزك بعد. يبدأ الحجز الساعة {$startsAt}.");
                }

                // منع type mismatch لو تغير نوع الغرفة بعد الحجز
                if ($booking->room_id) {
                    $room = Room::lockForUpdate()->find($booking->room_id);
                    if (!$room || $room->type !== 'booking') {
                        throw new \Exception('تعذّر تسجيل الدخول: نوع الغرفة لا يطابق نوع الحجز.');
                    }
                }

                $booking->update([
                    'status' => 'active',
                    'actual_start' => now(),
                ]);

                if ($booking->table_id) {
                    Table::where('id', $booking->table_id)->update(['is_occupied' => true]);
                } elseif ($booking->room_id) {
                    Room::where('id', $booking->room_id)->update(['is_occupied' => true]);
                }

                return $booking->load(['table', 'room']);
            }

            // =========================
            // (ب) Walk-in فوري — بدون تحديد مكان
            // =========================
            $discount = LuckyWheel::where('user_id', $userId)
                ->where('prize_type', 'discount')
                ->where('is_used', false)
                ->lockForUpdate()
                ->value('discount_percent') ?? 0;

            return Booking::create([
                'user_id' => $userId,
                'table_id' => null,
                'room_id' => null,
                'scheduled_start' => null,
                'scheduled_end' => null,
                'actual_start' => now(),
                'discount_percent' => $discount,
                'status' => 'active',
            ]);
        });
    }

    // =========================================================
    // 4. CHECK OUT (QR end session)
    // =========================================================

    public static function checkOut(int $userId): Booking
    {
        return DB::transaction(function () use ($userId) {

            // =========================
            // 1. جلب الجلسة النشطة
            // =========================
            $booking = Booking::where('user_id', $userId)
                ->where('status', 'active')
                ->whereNotNull('actual_start')
                ->lockForUpdate()
                ->first();

            if (!$booking) {
                throw new \Exception('لا توجد جلسة نشطة.');
            }

            // =========================
            // 2. حماية إضافية (Idempotency guard)
            // =========================
            if ($booking->status !== 'active') {
                throw new \Exception('الجلسة ليست نشطة.');
            }

            // =========================
            // 3. حساب الوقت
            // =========================
            $start = Carbon::parse($booking->actual_start);
            $end = now();

            $minutes = $start->diffInMinutes($end);

            if ($minutes < 1) {
                throw new \Exception('جلسة قصيرة جداً.');
            }

            $hours = round($minutes / 60, 2);

            // =========================
            // 4. حساب السعر
            // =========================
            $pricePerHour = self::getPricePerHour($userId);

            $rawPrice = $pricePerHour * $hours;

            $discountPercent = $booking->discount_percent ?? 0;

            $discountAmount = ($rawPrice * $discountPercent) / 100;

            $totalPrice = max(0, $rawPrice - $discountAmount);

            // =========================
            // 5. إغلاق الجلسة (Atomic update)
            // =========================
            $updated = Booking::where('id', $booking->id)
                ->where('status', 'active')
                ->update([
                    'actual_end' => $end,
                    'hours' => $hours,
                    'total_price' => $totalPrice,
                    'discount_amount' => $discountAmount,
                    'status' => 'completed',
                ]);

            if (!$updated) {
                throw new \Exception('تمت معالجة الجلسة مسبقاً.');
            }

            // =========================
            // 6. تحرير المكان (إن وجد)
            // =========================
            if ($booking->table_id) {
                Table::where('id', $booking->table_id)
                    ->where('is_occupied', true)
                    ->update(['is_occupied' => false]);
            }

            if ($booking->room_id) {
                Room::where('id', $booking->room_id)
                    ->where('is_occupied', true)
                    ->update(['is_occupied' => false]);
            }

            // =========================
            // 7. خصم من الباقة (إن وجد)
            // =========================
            self::deductFromSubscription($userId, $hours, $totalPrice);

            return $booking->fresh()->load(['table', 'room']);
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

    public static function getPricePerHour(int $userId): float
    {
        $sub = ConsumptionPackage::where('user_id', $userId)->active()->first();

        if ($sub) {
            return (float) $sub->price_per_hour;
        }

        return (float) Setting::where('key', 'default_price_per_hour')->value('value');
    }

    public static function deductFromSubscription(int $userId, float $hours, float $price): void
    {
        $sub = ConsumptionPackage::where('user_id', $userId)->active()->first();

        if (!$sub)
            return;

        $sub->update([
            'remaining_hours' => max(0, $sub->remaining_hours - $hours),
            'remaining_price' => max(0, $sub->remaining_price - $price),
        ]);
    }

}
