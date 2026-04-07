<?php

namespace App\Http\Requests\Booking;

use Illuminate\Foundation\Http\FormRequest;

class createBookingRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

        protected function prepareForValidation()
    {
        // ضمان أن المستخدم يختار واحد فقط
        if ($this->table_id && $this->room_id) {
            throw new \Exception('اختر إما طاولة أو غرفة وليس الاثنين.');
        }

        if (!$this->table_id && !$this->room_id) {
            throw new \Exception('يجب اختيار طاولة أو غرفة.');
        }
    }


    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'table_id'=>'nullable|exists:tables,id',
            'room_id'=>'nullable|exists:rooms,id',
            'scheduled_start'=>'required|date'
        ];
    }
}
