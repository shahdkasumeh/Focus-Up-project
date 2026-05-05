<?php

namespace App\Http\Requests\Post;

use Illuminate\Foundation\Http\FormRequest;

class StorePostRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'max:300'],
            'content' => ['required', 'string', 'max:300'],
        ];
    }

    public function messages(): array
    {
        return [
            'title.required' => 'The post title is required.',
            'title.max' => 'The title must not exceed 300 characters.',
            'content.required' => 'The post content is required.',
            'content.max' => 'The content must not exceed 300 characters.',
        ];
    }
}
