<?php
namespace App\Services;

use App\Models\LuckyWheelAdmin;

class LuckyWheelAdminService{

public static function query(){
    return LuckyWheelAdmin::query();
}

public static function create(array $data){
    $LW=LuckyWheelAdmin::create($data);
    return $LW->fresh();
}

public static function update(array $data, LuckyWheelAdmin $luckyWheelAdmin ){
    $luckyWheelAdmin->update($data);
    return $luckyWheelAdmin->fresh();
}

public static function delete (LuckyWheelAdmin $luckyWh){
    return $luckyWh->delete();
}



}
