<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;

class ConsumptionPackage extends Model
{
    protected $fillable = [
        'user_id',
        'package_id',
        'starts_at',
        'expires_at',
        'total_hours',
        'remaining_hours',
        'total_price',
        'remaining_price',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'starts_at'       => 'datetime',
            'expires_at'      => 'datetime',
            'total_hours'     => 'decimal:2',
            'remaining_hours' => 'decimal:2',
            'total_price'     => 'decimal:2',
            'remaining_price' => 'decimal:2',
        ];
    }

    // =========================================================
    // Relations
    // =========================================================

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function package()
    {
        return $this->belongsTo(Package::class);
    }

    // =========================================================
    // Scopes
    // =========================================================

    /**
     * باقة نشطة وصالحة (لم تنتهِ صلاحيتها ولم تصفر ساعاتها)
     */
    public function scopeActive($query)
    {
        return $query->where('status', 'active')
            ->where(function ($q) {
                $q->whereNull('expires_at')
                    ->orWhere('expires_at', '>', now());
            })
            ->where('remaining_hours', '>', 0);
    }

    public function scopePending($query)
{
    return $query->where('status', 'pending');
}

    // =========================================================
    // Helpers
    // =========================================================

    /**
     * هل الباقة صالحة للاستخدام الآن؟
     */
    public function isValid(): bool
    {
        if ($this->status !== 'active') {
            return false;
        }

        if ($this->remaining_hours <= 0) {
            return false;
        }

        if ($this->expires_at && $this->expires_at->isPast()) {
            return false;
        }

        return true;
    }
}
