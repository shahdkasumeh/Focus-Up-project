<?php

namespace App\Services;

use App\Models\ConsumptionPackage;
use App\Models\Package;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;

class ConsumptionPackageService
{

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

        $pending = ConsumptionPackage::where('user_id', $userId)
            ->pending()
            ->lockForUpdate()
            ->exists();

        if ($pending) {
            throw new \Exception('  اذهب للدفع ليتم تفعيلها pendingلديك باقة بحالة  ');
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

