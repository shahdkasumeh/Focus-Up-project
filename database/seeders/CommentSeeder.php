<?php

namespace Database\Seeders;

use App\Models\Comment;
use Illuminate\Database\Seeder;

class CommentSeeder extends Seeder
{
    public function run(): void
    {
        $comments = [

            [
                'content' => 'Great post! Very helpful.',
                'userid' => 2,
                'post_id' => 1,
            ],
            [
                'content' => 'Thanks for sharing this!',
                'userid' => 3,
                'post_id' => 1,
            ],

            [
                'content' => 'I really needed this information.',
                'userid' => 2,
                'post_id' => 2,
            ],

            [
                'content' => 'UDP is challenging but interesting!',
                'userid' => 1,
                'post_id' => 3,
            ],
            [
                'content' => 'Can you share the full code?',
                'userid' => 3,
                'post_id' => 3,
            ],

            [
                'content' => 'Resources are game changers!',
                'userid' => 1,
                'post_id' => 4,
            ],


            [
                'content' => 'Sanctum makes authentication so easy!',
                'userid' => 1,
                'post_id' => 5,
            ],
            [
                'content' => 'Thanks for the clear explanation',
                'userid' => 2,
                'post_id' => 5,
            ],
        ];

        foreach ($comments as $comment) {
            Comment::create($comment);
        }
    }
}
