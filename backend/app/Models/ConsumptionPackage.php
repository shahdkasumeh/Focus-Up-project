<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ConsumptionPackage extends Model
{
    /** @use HasFactory<\Database\Factories\ConsumptionPackageFactory> */
    use HasFactory;


    protected $fillable = [
        'user_id',
        'starts_at',
        'expires_at',
        'total_hours',
        'remaining_hours',
        'total_price',
        'remaining_price',
        'status',
    ];

    public function pakage()
    {
        return $this->belongsTo(Package::class);
    }


    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function scopeActive($query)
    {
        return $query->where('status', 'active')
            ->where('expires_at', '>', now())
            ->where('remaining_hours', '>', 0);
    }
}
