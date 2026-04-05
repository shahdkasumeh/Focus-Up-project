<?php
namespace App\Services;

use App\Models\Table;

class TableService{

public static function query(){
    return Table::query();
}

public static function create(array $data){
    $table= Table::create($data);
    return $table->fresh();
}

public static function update(array $data,Table $table){
    $table->update($data);
    return $table->fresh();
}

public static function delete(Table $table){
    return $table->delete();
}

}
