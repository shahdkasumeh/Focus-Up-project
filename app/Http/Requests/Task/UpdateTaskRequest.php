<?php

namespace App\Http\Requests\Task;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTaskRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['sometimes', 'string', 'max:30'],
            'description' => ['nullable', 'string', 'max:30'],
            'due_date' => ['nullable', 'date'],
            'status' => ['sometimes', 'string', 'in:pending,done'],
        ];
    }
}
