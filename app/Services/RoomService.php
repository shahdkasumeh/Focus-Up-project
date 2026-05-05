<?php
namespace App\Services;

use App\Models\Room;

class RoomService{

public static function query(){
    return Room::query();
}

public static function create(array $data){
    $room= Room::create($data);
    return $room->fresh();
}

public static function update(array $data,Room $room){
    $room->update($data);
    return $room->fresh();
}

public static function delete(Room $room){
    return $room->delete();
}

}
