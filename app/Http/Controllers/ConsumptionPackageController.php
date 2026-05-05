<?php

namespace App\Http\Controllers;

use App\Http\Resources\ConsumptionPackageResource;
use App\Models\ConsumptionPackage;
use App\Services\ConsumptionPackageService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ConsumptionPackageController extends Controller
{
    // =========================================================
    // 1. قائمة باقاتي (للمستخدم)
    // =========================================================

    public function index()
    {
        $packages = ConsumptionPackage::where('user_id', Auth::id())
            ->latest()
            ->get();

        return $this->success(
            ConsumptionPackageResource::collection($packages)
        );
    }

    // =========================================================
    // 2. قائمة كل الباقات (للإدارة)
    // =========================================================

    public function indexManagement()
    {
        $packages = ConsumptionPackage::with('user')
            ->latest()
            ->get();

        return $this->success(
            ConsumptionPackageResource::collection($packages)
        );
    }

    // =========================================================
    // 3. شراء باقة جديدة
    // =========================================================

    public function store(Request $request)
{
    $data = $request->validate([
        'package_id' => ['required', 'exists:packages,id'],
    ]);

    $package = ConsumptionPackageService::purchaseFromPlan(
        Auth::id(),
        $data['package_id']
    );

    return $this->success(
        ConsumptionPackageResource::make($package),
        201
    );
}
    // =========================================================
    // 4. عرض باقة بعينها
    // =========================================================

    public function show(ConsumptionPackage $consumptionPackage)
    {
        $this->authorizePackage($consumptionPackage);

        return $this->success(
            ConsumptionPackageResource::make($consumptionPackage)
        );
    }

    // =========================================================
    // 5. إلغاء باقة
    // =========================================================

    public function cancel(ConsumptionPackage $consumptionPackage)
    {
        $this->authorizePackage($consumptionPackage);

        $package = ConsumptionPackageService::cancel(
            $consumptionPackage->id,
            Auth::id()
        );

        return $this->success(
            ConsumptionPackageResource::make($package)
        );
    }

    // =========================================================
    // 6. الباقة النشطة حالياً للمستخدم
    // =========================================================

    public function active()
    {
        $package = ConsumptionPackageService::getActive(Auth::id());

        if (!$package) {
            return $this->success(null);
        }

        return $this->success(
            ConsumptionPackageResource::make($package)
        );
    }

    // =========================================================
    // 7. إحصائيات (للإدارة فقط)
    // =========================================================

    public function stats()
    {
        return $this->success(
            ConsumptionPackageService::stats()
        );
    }

    // =========================================================
    // Authorization helper
    // =========================================================

    private function authorizePackage(ConsumptionPackage $package): void
    {
        if ($package->user_id !== Auth::id()) {
            abort(403, 'Unauthorized');
        }
    }
}
