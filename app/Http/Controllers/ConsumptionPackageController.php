<?php

namespace App\Http\Controllers;

use App\Http\Resources\ConsumptionPackageResource;
use App\Http\Resources\EmployeePackageResource;
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
        'message: اذهب للمركز وقم بالدفع ليتم تفعيلهاpending اصبح لديك باقة بحالة '
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
    public function pending(){
        $package=ConsumptionPackage::with(['user','package'])
        ->where('status','pending')
        ->latest()
        ->get();
        return $this->success(
            EmployeePackageResource::collection($package)
        );
    }
    public function activeStatus($id){
        $package=ConsumptionPackage::find($id);
        $package->update([
            'status'=>'active'
        ]);
        return response()->json([
            'message'=>'Done'
        ]);

    }



}
