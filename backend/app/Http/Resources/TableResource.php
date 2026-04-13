<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TableResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return[

        "id"=>$this->id,
        "table_num"=>$this->table_num,
        'is_active'=>$this->is_active,
        'is_occupied'=>$this->is_occupied,
        "room_id"=>$this->room_id
        ];
    }
}
