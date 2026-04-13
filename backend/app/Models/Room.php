<?php

namespace App\Models;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Room extends Model
{
        protected $fillable = [
        'name',
        'type',
        'is_active',
        'is_occupied',
        'capacity',
        'status'
        ];

        public function tables()
        {
            return $this->hasMany(Table::class);
        }

        public function bookings()
        {
            return $this->hasMany(Booking::class);
        }

        public function scopeAvailable($query)
        {

    /** @var User $user */
    $user = Auth::user();

    if ($user->hasRole('admin')) {
        return $query;
    }
    return $query->where('status', 'active');
}
}
