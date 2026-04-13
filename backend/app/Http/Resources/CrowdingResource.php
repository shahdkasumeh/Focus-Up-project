<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CrowdingResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'room_id' => $this['room_id'],
            'room_name' => $this['room_name'],
            'room_type' => $this['room_type'],
            'capacity' => $this['capacity'],
            'tables' => [
                'total' => $this['total_tables'],
                'occupied' => $this['occupied_tables'],
                'available' => $this['total_tables'] - $this['occupied_tables'],
            ],
            'crowding' => [
                'percentage' => $this['percentage'],
                'color' => $this['color'],
                'status' => $this['status'],
                'message' => $this['message'],
            ],
        ];
    }

}
