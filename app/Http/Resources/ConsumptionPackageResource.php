<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ConsumptionPackageResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'              => $this->id,
            'status'          => $this->status,
            'total_hours'     => (float) $this->total_hours,
            'remaining_hours' => (float) $this->remaining_hours,
            'used_hours'      => round((float) $this->total_hours - (float) $this->remaining_hours, 2),
            'total_price'     => (float) $this->total_price,
            'remaining_price' => (float) $this->remaining_price,
            'starts_at'       => $this->starts_at?->setTimezone('Asia/Damascus')->toDateTimeString(),
            'expires_at'      => $this->expires_at?->setTimezone('Asia/Damascus')->toDateTimeString(),
            'created_at'      => $this->created_at->setTimezone('Asia/Damascus')->toDateTimeString(),

            // يظهر فقط في indexManagement
            'user' => $this->whenLoaded('user', fn() => [
                'id'   => $this->user->id,
                'name' => $this->user->name,
            ]),
        ];
    }
}
