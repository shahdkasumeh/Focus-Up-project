<?php

namespace App\Services;

use App\Models\Post;

class PostService
{
    public function getAll()
    {
        return Post::with('user')
            ->withCount('comments')
            ->latest()
            ->get();
    }

    public function getByUser(int $userId)
    {
        return Post::with('user')
            ->withCount('comments')
            ->where('userid', $userId)
            ->latest()
            ->get();
    }

    public function findWithDetails(int $postId): Post
    {
        return Post::with([
            'user',
            'comments' => fn($q) => $q->with('user')->latest(),
        ])
            ->withCount('comments')
            ->findOrFail($postId);
    }

    public function create(array $data, int $userId): Post
    {
        $post = Post::create([
            'title' => $data['title'],
            'content' => $data['content'],
            'userid' => $userId,
        ]);

        return $post->load('user');
    }

    public function update(Post $post, array $data, int $authUserId): Post
    {
        abort_if(
            $post->userid !== $authUserId,
            403,
            'You do not have permission to update this post.'
        );

        $post->update(array_filter($data));

        return $post->fresh('user');
    }

    public function delete(Post $post, int $authUserId, string $role): void
    {
        abort_if(
            $post->userid !== $authUserId && $role !== 'admin',
            403,
            'You do not have permission to delete this post.'
        );

        $post->delete();
    }
}
