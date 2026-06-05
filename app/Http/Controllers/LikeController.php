<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Services\LikeService;
use Illuminate\Http\JsonResponse;

class LikeController extends Controller
{
    public function __construct(private LikeService $likeService)
    {
    }

    public function toggle(Post $post): JsonResponse
    {
        $result = $this->likeService->toggleLike($post);

        return response()->json([
            'message' => $result['message'],
            'action' => $result['action'],
            'likes_count' => $result['likes_count'],
            'is_liked' => $result['is_liked'],
        ]);
    }
}
