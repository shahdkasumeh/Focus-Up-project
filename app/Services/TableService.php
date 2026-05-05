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

    public static function stats(): array
    {
          return [
            'total' => Table::count(),

            // محجوبة (pending)
            'pending' => Table::whereHas('bookings', function ($q) {
                $q->where('status', 'pending');
            })->count(),

            // مشغولة (active)
            'active' => Table::whereHas('bookings', function ($q) {
                $q->where('status', 'active');
            })->count(),

            // متاحة (لا pending ولا active)
            'available' => Table::whereDoesntHave('bookings', function ($q) {
                $q->whereIn('status', ['pending', 'active']);
            })->count(),
        ];
    }
}
