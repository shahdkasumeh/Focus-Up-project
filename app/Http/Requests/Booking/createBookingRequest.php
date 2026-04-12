<?php

namespace App\Http\Requests\Booking;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\ValidationException;

class CreateBookingRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    protected function prepareForValidation()
    {
        // تنظيف قيم null
        $this->merge([
            'table_id' => $this->table_id ?: null,
            'room_id'  => $this->room_id ?: null,
        ]);
    }

    public function rules(): array
    {
        return [
            'table_id' => 'nullable|exists:tables,id|required_without:room_id',
            'room_id'  => 'nullable|exists:rooms,id|required_without:table_id',

            'scheduled_start' => 'required|date|after_or_equal:now',
            'scheduled_end'   => 'required|date|after:scheduled_start',
        ];
    }

    public function messages(): array
    {
        return [
            'table_id.required_without' => 'يجب اختيار طاولة أو غرفة.',
            'room_id.required_without'  => 'يجب اختيار طاولة أو غرفة.',

            'scheduled_start.after_or_equal' => 'لا يمكن اختيار وقت في الماضي.',
            'scheduled_end.after' => 'وقت الانتهاء يجب أن يكون بعد البداية.',
        ];
    }
}
