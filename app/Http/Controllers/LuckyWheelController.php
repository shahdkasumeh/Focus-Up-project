<?php
namespace App\Http\Controllers;

use App\Models\LuckyWheel;
use App\Models\LuckyWheelAdmin;
use App\Services\LuckyWheelService;
use Illuminate\Support\Facades\Auth;

class LuckyWheelController extends Controller
{
    // =========================
    // عرض العجلة
    // =========================
    public function prizes()
    {
        return response()->json([
            'data' => LuckyWheelAdmin::all()->map(function ($item) {
                return [
                    'id' => $item->id,
                    'name'=>$item->name,
                    'value' => $item->value,
                ];
            })
        ]);
    }

    // =========================
    // هل يحق الدوران
    // =========================
    public function canSpin()
    {
        return response()->json(
            LuckyWheelService::canSpin(Auth::id())
        );
    }

    // =========================
    // spin
    // =========================
    public function spin()
{
    try {

        $result = LuckyWheelService::spin(Auth::id());

        return response()->json([
            'success' => true,

            'message' => 'تم الدوران بنجاح',

            'data' => [
                'name'  => $result->name,
                'value' => $result->value,
            ]
        ]);

    } catch (\Exception $e) {

        return response()->json([
            'success' => false,

            'message' => $e->getMessage(),
        ], 422);
    }
}

    public function gifts()
{
    $gifts = LuckyWheelService::getUnusedAdminGifts(Auth::id());

    return response()->json([
        'success' => true,
        'data' => $gifts
    ]);
}

public function claimGift($id)
{
    $gift = LuckyWheelService::claimGift(
        Auth::id(),
        $id
    );

    return response()->json([
        'success' => true,
        'message' => 'تم استلام الهدية',
        'data' => $gift
    ]);
}
public function myPrizesCurrent()
{
    return response()->json([
        'success' => true,
        'data' => LuckyWheelService::getCurrentRewards(Auth::id())
    ]);
}
public function myPrizes()
{
    return response()->json([
        'success' => true,
        'data' => LuckyWheelService::getUserPrizes(Auth::id())
    ]);
}
}
