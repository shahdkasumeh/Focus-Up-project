<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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
}
