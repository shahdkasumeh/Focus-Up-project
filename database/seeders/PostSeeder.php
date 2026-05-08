<?php

namespace Database\Seeders;

use App\Models\Post;
use Illuminate\Database\Seeder;

class PostSeeder extends Seeder
{
    public function run(): void
    {
        $posts = [
            [
                'title' => 'My First Post',
                'content' => 'This is my first post about Laravel API development',
                'userid' => 1,
                'likes_count' => 5,
            ],
            [
                'title' => 'API Development Tips',
                'content' => 'Best practices for building RESTful APIs with Laravel',
                'userid' => 1,
                'likes_count' => 3,
            ],
            [
                'title' => 'UDP Server Project',
                'content' => 'Building a real-time university update system using UDP',
                'userid' => 2,
                'likes_count' => 8,
            ],
            [
                'title' => 'Laravel Resources',
                'content' => 'How to use API resources to format your responses',
                'userid' => 2,
                'likes_count' => 2,
            ],
            [
                'title' => 'Sanctum Authentication',
                'content' => 'Token-based authentication with Laravel Sanctum',
                'userid' => 3,
                'likes_count' => 10,
            ],
        ];

        foreach ($posts as $post) {
            Post::create($post);
        }
    }
}
