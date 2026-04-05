<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
      protected $fillable = [
        'user_id',
        'table_id',
        'room_id',
        'scheduled_start',
        'actual_start',
        'actual_end',
        'hours',
        'total_price',
        'discount_percent',
        'discount_amount',
        'status',
    ];


public function room()
{
    return $this->belongsTo(Room::class);
}

public function table()
{
    return $this->belongsTo(Table::class);
}

public function consumptionPackage()
{
    return $this->belongsTo(ConsumptionPackage::class);
}
public function user()
{
    return $this->belongsTo(User::class);
}

public function luckyWeel()
{
    return $this->hasOne(LuckyWheel::class, 'used_in_booking_id');
}
}
