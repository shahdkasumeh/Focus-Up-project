<?php

namespace App\Http\Controllers;

use App\Http\Requests\Room\CreateRoomRequest;
use App\Http\Requests\Room\UpdateRoomRequest;
use App\Http\Resources\RoomResource;
use App\Models\Room;
use App\Services\RoomService;
use App\Traits\ResponseTrait;

class RoomController extends Controller
{
        use ResponseTrait;

    public function index()
    {
        return $this->success(
            RoomResource::collection(
                RoomService::query()->available()->get()
            )
        );
    }

    public function store(CreateRoomRequest $request)
    {
        return $this->success(
            RoomResource::make(
                RoomService::create($request->validated())
            )
        );
    }

    public function show(Room $room)
    {
        $room->load('tables');
        return $this->success(
            RoomResource::make($room)
        );
    }

    public function update( UpdateRoomRequest $request, Room $room)
    {
        return RoomResource::make(
        RoomService::update($request->validated(), $room)
    );
    }

    public function destroy(Room $room)
    {
        RoomService::delete($room);
        return $this->success('delete room successfuly');
    }
}
