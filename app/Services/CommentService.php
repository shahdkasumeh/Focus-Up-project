<?php

namespace App\Services;

use App\Models\Comment;
use App\Models\Post;

class CommentService
{
    public function create(Post $post, string $content, int $userId): Comment
    {
        $comment = Comment::create([
            'content' => $content,
            'userid' => $userId,
            'post_id' => $post->id,
        ]);

        return $comment->load('user');
    }

    public function update(Comment $comment, string $content, int $authUserId): Comment
    {
        abort_if(
            $comment->userid !== $authUserId,
            403,
            'You do not have permission to update this comment.'
        );

        $comment->update(['content' => $content]);

        return $comment->fresh('user');
    }

    public function delete(Comment $comment, int $authUserId, string $role, Post $post): void
    {
        $isOwner = $comment->userid === $authUserId;
        $isAdmin = $role === 'admin';
        $isPostOwner = $post->userid === $authUserId;

        abort_if(
            !$isOwner && !$isAdmin && !$isPostOwner,
            403,
            'You do not have permission to delete this comment.'
        );

        $comment->delete();
    }
}
