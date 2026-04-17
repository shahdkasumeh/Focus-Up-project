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
        'scheduled_end',
        'actual_start',
        'actual_end',
        'hours',
        'total_price',
        'discount_percent',
        'discount_amount',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'scheduled_start' => 'datetime',
            'scheduled_end' => 'datetime',
            'actual_start'    => 'datetime',
            'actual_end'      => 'datetime',
            'hours'           => 'decimal:2',
            'total_price'     => 'decimal:2',
            'discount_percent'=> 'decimal:2',
            'discount_amount' => 'decimal:2',
        ];
    }


public function room()
{
    return $this->belongsTo(Room::class);
}

public function table()
{
    return $this->belongsTo(Table::class);
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
