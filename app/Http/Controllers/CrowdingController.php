<?php


namespace App\Http\Controllers;

use App\Http\Resources\CrowdingResource;

use App\Models\Room;

use App\Services\CrowdingService;

use Illuminate\Http\Request;

class CrowdingController extends Controller
{

    protected CrowdingService $crowdingService;

    public function __construct(CrowdingService $crowdingService)
    {
        $this->crowdingService = $crowdingService;
    }

    // جيب حالة كل الغرف
    public function index()
    {
        $data = $this->crowdingService->getAllRoomsCrowding();

        return $this->success(
            $data,
            'Crowding status fetched successfully'
        );
    }

    public function indexCrowding(){
            return $this->success(
                CrowdingService::crowdingwalk()
                );
    }

    // جيب حالة غرفة محددة
    public function show($id)
    {
        $room = Room::find($id);

        if (!$room) {
            return $this->fail('Room not found');
        }

        $data = $this->crowdingService->getCrowdingStatus($room);

        return $this->success(
            new CrowdingResource($data),
            'Crowding status fetched successfully'
        );
    }


}
