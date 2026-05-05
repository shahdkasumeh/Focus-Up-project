<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PackageResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
            return [
            'id'=> $this->id,
            'name' => $this->name,
            'hours'=> $this->hours,
            'price'=> $this->price,
            'duration_days'=> $this->duration_days,
            'type'=> $this->type,
        

            // helper من الـ model
            'price_per_hour' => $this->price_per_hour,
        ];
    }
}
