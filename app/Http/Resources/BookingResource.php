<?php

namespace App\Http\Resources;

use App\Models\ConsumptionPackage;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BookingResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
    'id' => $this->id,
    'status' => $this->status,

    'scheduled_start' => $this->scheduled_start?->setTimezone('Asia/Damascus')->toDateTimeString(),
    'scheduled_end'   => $this->scheduled_end?->setTimezone('Asia/Damascus')->toDateTimeString(),

    'actual_start' => $this->actual_start?->setTimezone('Asia/Damascus')->toDateTimeString(),
    'actual_end'   => $this->actual_end?->setTimezone('Asia/Damascus')->toDateTimeString(),

    'hours' => $this->hours,
    'total_price' => $this->total_price,
    'discount_percent' => $this->discount_percent,
    'discount_amount' => $this->discount_amount,
    
    'payment_label' => $this->status === 'completed'
    ? (ConsumptionPackage::where('user_id', $this->user_id)
        ->whereIn('status', ['active', 'expired'])
        ->exists()
            ? 'مشترك — تم الخصم من الباقة'
            : ' غير مشترك — على الطالب الدفع نقداً')
    : null,

    'action' => $this->status === 'active'
        ? 'check_in'
        : ($this->status === 'completed' ? 'check_out' : null),

    'table' => $this->whenLoaded('table'),
    'room'  => $this->whenLoaded('room'),
];

    }
}
