<?php

// ======================================================
// app/Services/LuckyWheelService.php
// ======================================================

namespace App\Services;

use App\Models\Booking;
use App\Models\LuckyWheel;
use App\Models\LuckyWheelAdmin;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class LuckyWheelService
{
    // =========================================================
    // هل يحق للمستخدم الدوران؟
    // =========================================================

    public static function canSpin(int $userId): array
{
    $start = Carbon::now()->startOfWeek();
    $end   = Carbon::now()->endOfWeek();

    // عدد الحجوزات المكتملة
    $completedBookings = Booking::where('user_id', $userId)
        ->where('status', 'completed')
        ->whereBetween('actual_end', [$start, $end])
        ->count();

    // كم بقي
    $remaining = max(0, 3 - $completedBookings);

    // هل دار مسبقاً هذا الأسبوع؟
    $alreadySpun = LuckyWheel::where('user_id', $userId)
        ->whereDate('eligible_week_start', $start)
        ->exists();

    // يحق له؟
    $canSpin = $completedBookings >= 3 && !$alreadySpun;

    return [
        'can_spin' => $canSpin,
        'completed_bookings' => $completedBookings,
        'remaining_bookings' => $remaining,
        'already_spun' => $alreadySpun,
        'week_start' => $start->toDateString(),
        'week_end' => $end->toDateString(),
        'message' => $canSpin
            ? 'يمكنك تدوير العجلة.'
            : (
                $alreadySpun
                ? 'لقد استخدمت دورة هذا الأسبوع.'
                : "تحتاج {$remaining} حجوزات إضافية لتدوير العجلة."
            ),
    ];
}

    // =========================================================
    // تنفيذ الدوران
    // =========================================================

    public static function spin(int $userId): LuckyWheel
{
    return DB::transaction(function () use ($userId) {

        $eligibleWeek = self::getEligibleWeek($userId, true);

        if (!$eligibleWeek) {
            throw new \Exception(' لا يحق لك الدوران حالياً عليك بتجميع 3 حجوزات بالاسبوع');
        }

        $prize = self::pickPrize();

        if (!$prize) {
            throw new \Exception('لا توجد جوائز.');
        }

        return LuckyWheel::create([
            'user_id' => $userId,
            'lucky_wheel_admin_id' => $prize->id,


            'name'  => $prize->name,
            'value' => $prize->value,

            'is_used' => false,
            'spun_at' => now(),
            'eligible_week_start' => $eligibleWeek['start'],
        ]);

    });
}
    // =========================================================
    // جلب الأسبوع المؤهل
    // =========================================================

    private static function getEligibleWeek(
        int $userId,
        bool $lockForUpdate = false
    ): ?array {

        $weeks = [

            // هذا الأسبوع
            [
                'start' => Carbon::now()->startOfWeek(),
                'end'   => Carbon::now()->endOfWeek(),
            ],

            // الأسبوع الماضي
            [
                'start' => Carbon::now()->subWeek()->startOfWeek(),
                'end'   => Carbon::now()->subWeek()->endOfWeek(),
            ],
        ];

        foreach ($weeks as $week) {

            // لازم 3 حجوزات مكتملة
            $count = self::countCompletedBookings(
                $userId,
                $week['start'],
                $week['end']
            );

            if ($count < 3) {
                continue;
            }

            // هل دار مسبقاً؟
            $query = LuckyWheel::where('user_id', $userId)
                ->where('eligible_week_start', $week['start']);

            if ($lockForUpdate) {
                $query->lockForUpdate();
            }

            $alreadySpun = $query->exists();

            if (!$alreadySpun) {
                return $week;
            }
        }

        return null;
    }

    // =========================================================
    // عدد الحجوزات المكتملة
    // =========================================================

    private static function countCompletedBookings(
        int $userId,
        Carbon $start,
        Carbon $end
    ): int {
        return Booking::where('user_id', $userId)
            ->where('status', 'completed')
            ->whereBetween('actual_end', [$start, $end])
            ->count();
    }

    // =========================================================
    // اختيار جائزة عشوائية حسب الاحتمال
    // =========================================================

    private static function pickPrize(): ?LuckyWheelAdmin
    {
        $prizes = LuckyWheelAdmin::all();

        if ($prizes->isEmpty()) {
            return null;
        }
        // مجموع الاحتمالات
        $totalWeight = $prizes->sum('probability');
        // رقم عشوائي
        $random = rand(1, $totalWeight);

        $cumulative = 0;

        foreach ($prizes as $prize) {

            $cumulative += $prize->probability;

            if ($random <= $cumulative) {
                return $prize;
            }
        }
        return $prizes->last();
    }
    public static function claimGift(
    int $userId,
    int $wheelId
): LuckyWheel {

    $wheel = LuckyWheel::where('user_id', $userId)
        ->where('id', $wheelId)
        ->where('name', 'gift')
        ->where('is_used', false)
        ->lockForUpdate()
        ->firstOrFail();

    $wheel->update([
        'is_used' => true
    ]);

    return $wheel->fresh();
}
public static function getUnusedAdminGifts(int $userId)
{
    return LuckyWheel::where('user_id', $userId)
        ->where('name', 'gift')
        ->whereIn('is_used', [false,true])
        ->latest()
        ->get();
}
public static function getUserPrizes(int $userId)
{
    return LuckyWheel::where('user_id', $userId)
        ->latest()
        ->get([
            'id',
            'name',
            'value',
            'is_used',
            'spun_at'
        ]);
}
public static function getCurrentRewards(int $userId)
{
    return LuckyWheel::where('user_id', $userId)
        ->where('is_used', false)
        ->whereIn('name', [
            'discount',
            'gift'
        ])
        ->latest()
        ->get([
            'id',
            'name',
            'value',
            'spun_at'
        ]);
}
}
