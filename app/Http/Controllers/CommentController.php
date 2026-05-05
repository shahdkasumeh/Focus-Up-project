<?php

namespace App\Http\Controllers;

use App\Http\Requests\Comment\StoreCommentRequest;
use App\Http\Requests\Comment\UpdateCommentRequest;
use App\Http\Resources\CommentResource;
use App\Models\Comment;
use App\Models\Post;
use App\Services\CommentService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CommentController extends Controller
{
    public function __construct(private readonly CommentService $commentService)
    {
    }

    public function store(StoreCommentRequest $request, Post $post): JsonResponse
    {
        $comment = $this->commentService->create(
            post: $post,
            content: $request->validated('content'),
            userId: $request->user()->id,
        );

        return (new CommentResource($comment))
            ->response()
            ->setStatusCode(201);
    }

    public function update(UpdateCommentRequest $request, Post $post, Comment $comment): CommentResource
    {
        $comment = $this->commentService->update(
            comment: $comment,
            content: $request->validated('content'),
            authUserId: $request->user()->id,
        );

        return new CommentResource($comment);
    }

    public function destroy(Request $request, Post $post, Comment $comment): JsonResponse
    {
        $this->commentService->delete(
            comment: $comment,
            authUserId: $request->user()->id,
            role: $request->user()->role_type,
            post: $post,
        );

        return response()->json(['message' => 'Comment deleted successfully.']);
    }
}
