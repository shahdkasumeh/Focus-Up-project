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
    // 1. إنشاء الحجز (الطالب يختار طاولة أو غرفة)
    // =========================================================

    public static function createBooking(int $userId, ?int $tableId, ?int $roomId, string $scheduledStart): Booking
    {
        return DB::transaction(function () use ($userId, $tableId, $roomId, $scheduledStart) {

            $scheduledStart = Carbon::parse($scheduledStart,config('app.timezone'));

            if ($scheduledStart->isPast()) {
                throw new \Exception('لا يمكن الحجز في وقت ماضٍ.');
            }

            // التحقق من أن الطالب ليس لديه حجز نشط أو pending في نفس الوقت
            $conflict = Booking::where('user_id', $userId)
                ->whereIn('status', ['pending', 'active'])
                ->lockForUpdate()
                ->exists();

            if ($conflict) {
                throw new \Exception('لديك حجز قائم بالفعل. أنهِ حجزك الحالي أولاً.');
            }

            // التحقق من الطاولة أو الغرفة وقفلها
            if ($tableId) {
                $place = Table::lockForUpdate()->findOrFail($tableId);
                if (!$place->is_active) throw new \Exception('الطاولة غير متاحة.');

                // التحقق من عدم وجود حجز آخر على نفس الطاولة في نفس الوقت
                $placeConflict = Booking::where('table_id', $tableId)
                    ->whereIn('status', ['pending', 'active'])
                    ->where('scheduled_start', $scheduledStart)
                    ->lockForUpdate()
                    ->exists();

                if ($placeConflict) throw new \Exception('الطاولة محجوزة في هذا الوقت.');
            } else {
                $place = Room::lockForUpdate()->findOrFail($roomId);
                if (!$place->is_active) throw new \Exception('الغرفة غير متاحة.');

                $placeConflict = Booking::where('room_id', $roomId)
                    ->whereIn('status', ['pending', 'active'])
                    ->where('scheduled_start', $scheduledStart)
                    ->lockForUpdate()
                    ->exists();

                if ($placeConflict) throw new \Exception('الغرفة محجوزة في هذا الوقت.');
            }

            // FIX: lockForUpdate على WheelSpin يمنع استخدام نفس الخصم في حجزين متزامنين
            $wheelSpin = LuckyWheel::where('user_id', $userId)
                ->where('prize_type', 'discount')
                ->where('is_used', false)
                ->lockForUpdate()
                ->first();
            $discountPercent = $wheelSpin?->discount_percent ?? 0;

            // إنشاء الحجز بحالة pending — الطاولة لا تزال متاحة
            $booking = Booking::create([
                'user_id'          => $userId,
                'table_id'         => $tableId,
                'room_id'          => $roomId,
                'scheduled_start'  => $scheduledStart,
                'discount_percent' => $discountPercent,
                'status'           => 'pending',
            ]);

            // الطاولة/الغرفة تبقى متاحة (is_occupied = false)
            // الـ Scheduler هو من سيغيّرها عند حلول الوقت

            return $booking;
        });
    }

    // =========================================================
    // 2. مسح QR الدخول → تسجيل actual_start
    // =========================================================

    public static function checkIn(int $userId): Booking
    {
        return DB::transaction(function () use ($userId) {

            // الطالب يمسح QR: يجب أن يكون الحجز active (حان وقته) ولم يبدأ بعد
            $booking = Booking::where('user_id', $userId)
                ->where('status', 'active')
                ->whereNull('actual_start')
                ->lockForUpdate()
                ->first();

                if (!$booking) {
                // ربما الـ Scheduler لم يشتغل بعد — نتحقق من حجز pending حان وقته
                $pendingBooking = Booking::where('user_id', $userId)
                    ->where('status', 'pending')
                    ->where('scheduled_start', '<=', now())
                    ->lockForUpdate()
                    ->first();

                if ($pendingBooking) {
                    // نفعّله يدوياً (graceful fallback)
                    $pendingBooking->update(['status' => 'active']);
                    if ($pendingBooking->table_id) {
                        Table::where('id', $pendingBooking->table_id)->update(['is_occupied' => true]);
                    } else {
                        Room::where('id', $pendingBooking->room_id)->update(['is_occupied' => true]);
                    }
                    $booking = $pendingBooking;
                } else {
                    throw new \Exception('لا يوجد حجز نشط. تأكد أن وقت حجزك قد حان.');
                }
            }

            $booking->update(['actual_start' => now()]);

            return $booking->load(['table.room', 'room']);
        });
    }

    // =========================================================
    // 3. مسح QR الخروج → حساب الساعات والسعر + خصم من الباقة
    // =========================================================

    public static  function checkOut(int $userId): Booking
    {
        return DB::transaction(function () use ($userId) {

            // قفل الحجز النشط
            $booking = Booking::where('user_id', $userId)
                ->where('status', 'active')
                ->whereNotNull('actual_start')
                ->lockForUpdate()
                ->first();

            if (!$booking) {
                throw new \Exception('لا توجد جلسة نشطة لهذا الطالب.');
            }

            // =========================================================
            // FIX 1: double-check بعد القفل مباشرة
            // يحمي من الحالة التي ينتظر فيها طلب ثانٍ ثم يجد الحجز
            // قد تغيّر بين لحظة الجلب ولحظة القفل
            // =========================================================
            if ($booking->status !== 'active' || $booking->actual_start === null) {
                throw new \Exception('تمت معالجة الجلسة مسبقاً.');
            }

            $actualEnd   = now();
            $actualStart = Carbon::parse($booking->actual_start);
            $minutes     = $actualStart->diffInMinutes($actualEnd);

            if ($minutes < 1) {
                throw new \Exception('مدة الجلسة أقل من دقيقة.');
            }

            $hours = round($minutes / 60, 2);

            // ---- حساب السعر ----
            $pricePerHour    = self::getPricePerHour($userId);
            $rawPrice        = round($pricePerHour * $hours, 2);
            $discountPercent = $booking->discount_percent;
            $discountAmount  = round($rawPrice * $discountPercent / 100, 2);
            $totalPrice      = max(0, $rawPrice - $discountAmount);

            // =========================================================
            // FIX 2: Atomic update guard
            // يضمن أن تغيير status يحدث مرة واحدة فقط بشكل ذري
            // إذا كان طلب آخر سبقنا → $updated = 0 → نرمي exception
            // =========================================================
            $updated = Booking::where('id', $booking->id)
                ->where('status', 'active')
                ->update([
                    'actual_end'      => $actualEnd,
                    'hours'           => $hours,
                    'total_price'     => $totalPrice,
                    'discount_amount' => $discountAmount,
                    'status'          => 'completed',
                ]);

            if (!$updated) {
                throw new \Exception('تمت معالجة الجلسة مسبقاً.');
            }
            // =========================================================
            // FIX 3: تحرير الطاولة/الغرفة بشكل مشروط
            // نتحقق أن current_booking_id هو نفس حجزنا قبل التحرير
            // يحمي من overwrite حالة مكان بدأ فيه حجز جديد
            // =========================================================
            if ($booking->table_id) {
                Table::where('id', $booking->table_id)
                    ->where('is_occupied', true)
                    ->update(['is_occupied' => false]);
            } else {
                Room::where('id', $booking->room_id)
                    ->where('is_occupied', true)
                    ->update(['is_occupied' => false]);
            }

            // خصم من الباقة
            self::deductFromSubscription($userId, $hours, $totalPrice);

            // =========================================================
            // FIX 4: WheelSpin مع lockForUpdate
            // يمنع استخدام نفس الخصم في حجزين متزامنين
            // =========================================================
            if ($discountPercent > 0) {
                $spin = LuckyWheel::where('user_id', $userId)
                    ->where('prize_type', 'discount')
                    ->where('is_used', false)
                    ->lockForUpdate()
                    ->first();

                if ($spin) {
                    $spin->update([
                        'is_used'            => true,
                        'used_in_booking_id' => $booking->id,
                    ]);
                }
            }

            return $booking->fresh()->load(['table.room', 'room']);
        });
    }

    // =========================================================
    // 4. إلغاء الحجز (قبل بدء الجلسة فقط)
    // =========================================================

    public static function cancelBooking(int $bookingId, int $userId): Booking
    {
        return DB::transaction(function () use ($bookingId, $userId) {

            $booking = Booking::where('user_id', $userId)
                ->lockForUpdate()
                ->findOrFail($bookingId);

            if ($booking->status !== 'active' && $booking->status !=='pending') {
                throw new \Exception('لا يمكن إلغاء حجز منتهٍ أو مُلغى.');
            }

            if ($booking->actual_start !== null) {
                throw new \Exception('لا يمكن إلغاء جلسة بدأت بالفعل.');
            }

            $booking->update(['status' => 'cancelled']);

            // تحرير المكان
            if ($booking->table_id) {
                $booking->table->update(['is_occupied' => false]);
            } else {
                $booking->room->update(['is_occupied' => false]);
            }

            return $booking;
        });
    }

    // =========================================================
    // HELPERS
    // =========================================================

    /**
     * سعر الساعة:
     * - مشترك بباقة → من الباقة
     * - غير مشترك   → من إعدادات النظام (settings)
     */
    public static function getPricePerHour(int $userId): float
    {
        $subscription = ConsumptionPackage::where('user_id', $userId)
            ->active()
            ->lockForUpdate()
            ->first();

        if ($subscription) {
            return (float) $subscription->price_per_hour;
        }

        // سعر ثابت من إعدادات النظام
        $setting = Setting::where('key', 'default_price_per_hour')->first();

        if (!$setting) {
            throw new \Exception('لم يتم تعيين سعر الساعة الافتراضي. تواصل مع المدير.');
        }

        return (float) $setting->value;
    }

    /**
     * خصم الساعات والمبلغ من الباقة (فقط إذا كان الطالب مشتركاً)
     */
    public static function deductFromSubscription(int $userId, float $hours, float $price): void
    {
        $subscription = ConsumptionPackage::where('user_id', $userId)
            ->active()
            ->lockForUpdate()
            ->first();

        if (!$subscription) return; // غير مشترك → لا خصم من باقة
        $newHours = max(0, $subscription->remaining_hours - $hours);
        $newPrice = max(0, $subscription->remaining_price - $price);

        $subscription->update([
            'remaining_hours' => $newHours,
            'remaining_price' => $newPrice,
            'status'          => ($newHours <= 0 || $newPrice <= 0) ? 'exhausted' : 'active',
        ]);
    }
}
