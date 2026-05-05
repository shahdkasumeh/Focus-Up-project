<?php

namespace App\Http\Requests\Package;

use Illuminate\Foundation\Http\FormRequest;

class UpdatePackageRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            "name"=>"string|required|",
            "hours"=> "required|integer",
            "price"=> "required|decimal:3,10",
            "duration_days"=>"required|integer",

            'is_active'=>['sometimes','in:0,1']
        ];
    }
}
