<?php

namespace App\Services;

use App\Models\ConsumptionPackage;
use App\Models\Package;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ConsumptionPackageService
{
    // =========================================================
    // 1. شراء باقة جديدة
    // =========================================================

    /**
     * @param  int        $userId
     * @param  float      $totalHours   إجمالي ساعات الباقة
     * @param  float      $totalPrice   سعر الباقة كاملاً
     * @param  Carbon|string|null $expiresAt  تاريخ انتهاء الصلاحية (اختياري)
     */
    public static function purchase(
        int $userId,
        float $totalHours,
        float $totalPrice,
        $expiresAt = null
    ): ConsumptionPackage {

        return DB::transaction(function () use (
            $userId, $totalHours, $totalPrice, $expiresAt
        ) {
            // منع امتلاك أكثر من باقة نشطة واحدة في نفس الوقت
            $existing = ConsumptionPackage::where('user_id', $userId)
                ->active()
                ->lockForUpdate()
                ->exists();

            if ($existing) {
                throw new \Exception('لديك باقة نشطة بالفعل. أنهِ الباقة الحالية أو انتظر حتى تنتهي.');
            }

            if ($totalHours <= 0) {
                throw new \Exception('عدد الساعات يجب أن يكون أكبر من الصفر.');
            }

            if ($totalPrice < 0) {
                throw new \Exception('سعر الباقة لا يمكن أن يكون سالباً.');
            }

            $expiry = $expiresAt ? Carbon::parse($expiresAt) : null;

            if ($expiry && $expiry->isPast()) {
                throw new \Exception('تاريخ انتهاء الصلاحية لا يمكن أن يكون في الماضي.');
            }

            return ConsumptionPackage::create([
                'user_id'         => $userId,
                'starts_at'       => now(),
                'expires_at'      => $expiry,
                'total_hours'     => $totalHours,
                'remaining_hours' => $totalHours,
                'total_price'     => $totalPrice,
                'remaining_price' => $totalPrice,
                'status'          => 'active',
            ]);
        });
    }

    // =========================================================
    // 2. خصم من الباقة بعد checkOut
    //    يُستدعى من BookingService::checkOut
    // =========================================================

    /**
     * يُحاول خصم ساعات الجلسة من الباقة النشطة.
     *
     * منطق الخصم:
     *  - إذا كانت الساعات المتبقية في الباقة >= ساعات الجلسة:
     *      خصم كامل من الباقة (رصيد الساعات + رصيد المبلغ)
     *  - إذا كانت الساعات المتبقية أقل (الباقة تغطي جزءاً فقط):
     *      خصم ما تبقّى في الباقة وتُعلَّم expired
     *      (الفرق يُحسب بالسعر العادي في BookingService)
     *
     * @return array{deducted_hours: float, deducted_amount: float, package_expired: bool}
     */
    public static function deductFromSubscription(
        int $userId,
        float $sessionHours,
        float $sessionAmount
    ): array {

        return DB::transaction(function () use ($userId, $sessionHours, $sessionAmount) {

            // جلب الباقة النشطة مع قفل للكتابة (Pessimistic lock)
            $package = ConsumptionPackage::where('user_id', $userId)
                ->active()
                ->lockForUpdate()
                ->first();

            // لا توجد باقة نشطة → لا خصم
            if (!$package) {
                return [
                    'deducted_hours'  => 0,
                    'deducted_amount' => 0,
                    'package_expired' => false,
                ];
            }

            $remainingHours  = (float) $package->remaining_hours;
            $remainingAmount = (float) $package->remaining_price;

            // ============================================
            // الحالة 1: الباقة تغطي الجلسة كاملاً
            // ============================================
            if ($remainingHours >= $sessionHours) {


// نسبة استهلاك المبلغ = نفس نسبة الساعات
                $amountRatio     = ($remainingAmount > 0 && $package->total_hours > 0)
                    ? ($sessionHours / (float) $package->total_hours)
                    : 0;
                $deductedAmount  = round(min($package->total_price * $amountRatio, $remainingAmount), 2);
                $newHours        = round($remainingHours - $sessionHours, 2);
                $newAmount       = round(max(0, $remainingAmount - $deductedAmount), 2);

                $expired = ($newHours <= 0);

                $package->update([
                    'remaining_hours' => $newHours,
                    'remaining_price' => $newAmount,
                    'status'          => $expired ? 'expired' : 'active',
                ]);

                return [
                    'deducted_hours'  => $sessionHours,
                    'deducted_amount' => $deductedAmount,
                    'package_expired' => $expired,
                ];
            }

            // ============================================
            // الحالة 2: الباقة تغطي جزءاً فقط
            // ============================================
            $deductedHours  = $remainingHours;   // نستهلك ما تبقّى
            $deductedAmount = $remainingAmount;   // ونستنفد الرصيد المالي

            $package->update([
                'remaining_hours' => 0,
                'remaining_price' => 0,
                'status'          => 'expired',
            ]);

            return [
                'deducted_hours'  => $deductedHours,
                'deducted_amount' => $deductedAmount,
                'package_expired' => true,
            ];
        });
    }

    // =========================================================
    // 3. إلغاء الباقة
    // =========================================================

    public static function cancel(int $packageId, int $userId): ConsumptionPackage
    {
        return DB::transaction(function () use ($packageId, $userId) {

            $package = ConsumptionPackage::where('user_id', $userId)
                ->lockForUpdate()
                ->findOrFail($packageId);

            if (!in_array($package->status, [ 'active'])) {
                throw new \Exception('لا يمكن إلغاء هذه الباقة.');
            }

            $package->update(['status' => 'cancelled']);

            return $package->fresh();
        });
    }

    // =========================================================
    // 4. انتهاء صلاحية الباقات (يُشغَّل عبر Scheduled Command)
    // =========================================================

    /**
     * يُعلِّم الباقات المنتهية الصلاحية أو المستنفَدة كـ expired.
     * شغّله عبر Artisan command أو Laravel Scheduler كل ساعة.
     *
     * @return int عدد الباقات التي تم تحديثها
     */
    public static function expireStale(): int
    {
        return ConsumptionPackage::where('status', 'active')
            ->where(function ($q) {
                $q->where('expires_at', '<', now())
                    ->orWhere('remaining_hours', '<=', 0);
            })
            ->update(['status' => 'expired']);
    }

    // =========================================================
    // 5. جلب الباقة النشطة للمستخدم
    // =========================================================

    public static function getActive(int $userId): ?ConsumptionPackage
    {
        return ConsumptionPackage::where('user_id', $userId)
            ->active()
            ->latest()
            ->first();
    }

    // =========================================================
    // 6. إحصائيات (للإدارة)
    // =========================================================

    public static function stats(): array
    {
        return [
            'total'     => ConsumptionPackage::count(),
            'active'    => ConsumptionPackage::where('status', 'active')->count(),
            'expired'   => ConsumptionPackage::where('status', 'expired')->count(),
            'cancelled' => ConsumptionPackage::where('status', 'cancelled')->count(),
            'revenue'   => ConsumptionPackage::where('status', '!=', 'cancelled')
        ->sum('total_price'),
        ];
    }

    public static function purchaseFromPlan(int $userId, int $planId): ConsumptionPackage
{
    return DB::transaction(function () use ($userId, $planId) {

        $existing = ConsumptionPackage::where('user_id', $userId)
            ->active()
            ->lockForUpdate()
            ->exists();

        if ($existing) {
            throw new \Exception('لديك باقة نشطة بالفعل.');

        }
        $plan = Package::where('is_active', true)
            ->findOrFail($planId);

        return ConsumptionPackage::create([
            'user_id'         => $userId,
            'starts_at'       => now(),
            'expires_at'      => now()->addDays($plan->duration_days),
            'total_hours'     => $plan->hours,
            'remaining_hours' => $plan->hours,
            'total_price'     => $plan->price,
            'remaining_price' => $plan->price,
            'status'          => 'pending',
        ]);
    });
}
}

