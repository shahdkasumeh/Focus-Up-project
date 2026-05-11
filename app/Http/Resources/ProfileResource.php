<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfileResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id'           => $this->id,
            'image'        => $this->image
                                ? asset('storage/' . $this->image)
                                : null,
            'address'      => $this->address,
            'birth_date'   => $this->birth_date,
            'gender'       => $this->gender,
            'study_level'  => $this->study_level,
            'has_discount' => $this->has_discount,
            'user' => [
                'id'       => $this->user?->id,
                'fullname' => $this->user?->full_name,
                'email'    => $this->user?->email,
            ],
        ];
    }
}
