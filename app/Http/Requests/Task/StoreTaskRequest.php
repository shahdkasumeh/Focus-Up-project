<?php

namespace App\Http\Requests\Task;

use Illuminate\Foundation\Http\FormRequest;

class StoreTaskRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'max:30'],
            'description' => ['nullable', 'string', 'max:30'],
            'due_date' => ['nullable', 'date', 'after_or_equal:today'],
        ];
    }

    public function messages(): array
    {
        return [
            'title.required' => 'The task title is required.',
            'title.max' => 'The title must not exceed 30 characters.',
            'due_date.date' => 'The due date is not a valid date.',
            'due_date.after_or_equal' => 'You cannot add a task with a past date. Please select today or a future date.', 
        ];
    }
}
