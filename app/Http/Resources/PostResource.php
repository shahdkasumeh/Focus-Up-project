<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

use App\Services\LikeService;


class PostResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $likeService = new LikeService();

        return [
            'id' => $this->id,
            'title' => $this->title,
            'content' => $this->content,
            'created_at' => $this->created_at?->toDateTimeString(),
            'user' => [
                'id' => $this->user?->id,
                'full_name' => $this->user?->full_name,
            ],
            'comments_count' => $this->whenCounted('comments'),
            'comments' => CommentResource::collection($this->whenLoaded('comments')),
            'is_owner' => $this->userid === auth()->id(),
            'likes_count' => $this->likes_count ?? 0,
            'is_liked' => $likeService->isLikedByUser($this->resource),
        ];
    }
}
