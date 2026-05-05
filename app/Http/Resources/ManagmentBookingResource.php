<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ManagmentBookingResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            // =========================
            // BASIC INFO
            // =========================
            'id_booking' => $this->id,
            'status' => $this->status,

            // =========================
            // USER INFO (IMPORTANT)
            // =========================
            'user' => [
                'id' => $this->user?->id,
                'full_name' => $this->user?->full_name,
            ],

            // =========================
            // PLACE INFO
            // =========================
            'place' => [
                'type' => $this->table_id
                    ? 'table'
                    : ($this->room_id ? 'room' : 'walk_in'),

                'name' => $this->table_id
                    ? 'Table ' . $this->table_id
                    : ($this->room_id ? 'Room ' . $this->room_id : 'Walk-in'),

                'id' => $this->table_id ?? $this->room_id,
            ],

            // =========================
            // SCHEDULED TIME
            // =========================
            'scheduled_start' => $this->scheduled_start
                ? $this->scheduled_start->setTimezone('Asia/Damascus')->toDateTimeString()
                : null,

            'scheduled_end' => $this->scheduled_end
                ? $this->scheduled_end->setTimezone('Asia/Damascus')->toDateTimeString()
                : null,

            // =========================
            // ACTUAL SESSION
            // =========================
            'actual_start' => $this->actual_start
                ? $this->actual_start->setTimezone('Asia/Damascus')->toDateTimeString()
                : null,

            'actual_end' => $this->actual_end
                ? $this->actual_end->setTimezone('Asia/Damascus')->toDateTimeString()
                : null,

            // =========================
            // DURATION + PRICE
            // =========================
            'hours' => $this->hours,
            'total_price' => $this->total_price,

            'discount_percent' => $this->discount_percent,
            'discount_amount' => $this->discount_amount,

            // =========================
            // CONTROL FLAGS (for UI)
            // =========================
            'can_check_in' => $this->status === 'pending',
            'can_check_out' => $this->status === 'active',

            'is_active_session' => $this->status === 'active',
            'is_finished' => $this->status === 'completed',
        ];
    }
}
