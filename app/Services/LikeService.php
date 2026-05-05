<?php

namespace App\Services;

use App\Models\Post;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;

class LikeService
{
    public function toggleLike(Post $post)
    {
        $user = Auth::user();

        // منع الإعجاب بإعلانك الخاص (اختياري)
        if ($post->usersid === $user->id) {
            abort(403, 'You cannot like your own post.');
        }

        $cacheKey = "user_{$user->id}_liked_post_{$post->id}";

        if (Cache::has($cacheKey)) {
            // إلغاء اللايك
            Cache::forget($cacheKey);
            $post->decrement('likes_count');
            return [
                'action' => 'unliked',
                'message' => 'You unliked this post.',
                'likes_count' => $post->fresh()->likes_count,
                'is_liked' => false,
            ];
        } else {
            // إضافة لايك
            Cache::put($cacheKey, true, now()->addDays(30)); // يخزن لمدة 30 يوم
            $post->increment('likes_count');
            return [
                'action' => 'liked',
                'message' => 'You liked this post.',
                'likes_count' => $post->fresh()->likes_count,
                'is_liked' => true,
            ];
        }
    }

    public function isLikedByUser(Post $post)
    {
        $user = Auth::user();
        if (!$user)
            return false;

        $cacheKey = "user_{$user->id}_liked_post_{$post->id}";
        return Cache::has($cacheKey);
    }
}
