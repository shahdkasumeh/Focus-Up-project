<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Ramsey\Uuid\Type\Decimal;

class Package extends Model
{
    protected $fillable = [
        'name',
        'hours',
        'price',
        'duration_days',
        'type',
        'is_active',
    ];


        public function getPricePerHourAttribute(): float
    {
        if ($this->hours <= 0) {
            return 0;
        }

        return $this->price / $this->hours;
    }
    public function consumptionPackages()
    {
        return $this->hasMany(ConsumptionPackage::class);
    }
}
