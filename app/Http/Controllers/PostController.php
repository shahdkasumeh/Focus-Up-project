<?php

namespace App\Http\Controllers;

use App\Http\Requests\Post\StorePostRequest;
use App\Http\Requests\Post\UpdatePostRequest;
use App\Http\Resources\PostResource;
use App\Models\Post;
use App\Services\PostService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class PostController extends Controller
{
    public function __construct(private readonly PostService $postService)
    {
    }

    public function index()
    {
        $posts = $this->postService->getAll();

        return PostResource::collection($posts);
    }
    public function myPosts(Request $request)
    {
        $posts = $this->postService->getByUser($request->user()->id);

        return PostResource::collection($posts);
    }

    public function store(StorePostRequest $request): JsonResponse
    {
        $post = $this->postService->create(
            data: $request->validated(),
            userId: $request->user()->id,
        );

        return (new PostResource($post))
            ->response()
            ->setStatusCode(201);
    }

    public function show(int $postId): PostResource
    {
        $post = $this->postService->findWithDetails($postId);

        return new PostResource($post);
    }

    public function update(UpdatePostRequest $request, Post $post): PostResource
    {
        $post = $this->postService->update(
            post: $post,
            data: $request->validated(),
            authUserId: $request->user()->id,
        );

        return new PostResource($post);
    }

    public function destroy(Request $request, Post $post): JsonResponse
    {
        $this->postService->delete(
            post: $post,
            authUserId: $request->user()->id,
            role: $request->user()->role_type,
        );

        return response()->json(['message' => 'Post deleted successfully.']);
    }
}
