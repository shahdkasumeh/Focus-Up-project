<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Package extends Model
{
    protected $fillable = [
        'type',
        'price',
        'duration_hours',
        'status'
    ];
    public function consumptionPackages()
    {
        return $this->hasMany(ConsumptionPackage::class);
    }
}
