<?php

namespace App\Http\Resources;

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
            'scheduled_start' => $this->scheduled_start,
            'actual_start' => $this->actual_start,
            'actual_end' => $this->actual_end,
            'hours' => $this->hours,
            'total_price' => $this->total_price,
            'discount_percent' => $this->discount_percent,
            'discount_amount' => $this->discount_amount,
            'table' => $this->whenLoaded('table'),
            'room'  => $this->whenLoaded('room'),


        ];
    }
}
