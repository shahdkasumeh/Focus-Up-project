<?php
namespace App\Services;

use App\Models\Package;
use App\Models\Table;

class PackageService{

public static function query(){
    return Package::query();
}

public static function create(array $data){
    $package= Package::create($data);
    return $package->fresh();
}

public static function update(array $data,Package $package){
    $package->update($data);
    return $package->fresh();
}

public static function delete(Package $package){
    return $package->delete();
}

}
