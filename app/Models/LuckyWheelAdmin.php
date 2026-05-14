<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LuckyWheelAdmin extends Model
{
    protected $fillable = [
        'name',
        'value',
        'probability'
    ];

    public function luckyWheel(){
        return $this->hasMany(LuckyWheel::class);
    }
}
