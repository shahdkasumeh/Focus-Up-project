<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Package extends Model
{
    /** @use HasFactory<\Database\Factories\PackageFactory> */
    use HasFactory;
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
