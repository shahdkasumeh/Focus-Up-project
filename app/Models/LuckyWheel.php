<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LuckyWheel extends Model
{
    protected $fillable = [
        'user_id',
        'prize_type',
        'discount_percent',
        'message',
        'is_used',
        'used_in_booking_id'
    ];

    public function booking()
{
    return $this->belongsTo(Booking::class, 'used_in_booking_id');
}
}
