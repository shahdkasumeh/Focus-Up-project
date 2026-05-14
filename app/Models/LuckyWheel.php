<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LuckyWheel extends Model
{
    protected $fillable = [
        'user_id',
        'lucky_wheel_admin_id',
        'name',
        'value',
        'is_used',
        'used_in_booking_id',
        'spun_at',
        'eligible_week_start'
    ];

    public function booking()
{
    return $this->belongsTo(Booking::class, 'used_in_booking_id');
}

public function user(){
    return $this->belongsTo(User::class);
}

public function luckyWheelAdmin(){
    return $this->belongsTo(LuckyWheelAdmin::class);
}




}
