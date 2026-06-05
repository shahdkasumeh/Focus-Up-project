<?php

namespace App\Http\Controllers;

use App\Http\Requests\Task\StoreTaskRequest;
use App\Http\Requests\Task\UpdateTaskRequest;
use App\Http\Resources\TaskResource;
use App\Models\Task;
use App\Services\TaskService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class TaskController extends Controller
{
    public function __construct(private readonly TaskService $taskService)
    {
    }


    public function index(Request $request): AnonymousResourceCollection
    {
        $tasks = $this->taskService->getByDate(
            userId: $request->user()->id,
            date: $request->get('date'),
        );

        return TaskResource::collection($tasks);
    }


    // public function store(StoreTaskRequest $request): JsonResponse
    // {
    //     $task = $this->taskService->create(
    //         data: $request->validated(),
    //         userId: $request->user()->id,
    //     );

    //     return (new TaskResource($task))
    //         ->response()
    //         ->setStatusCode(201);
    // }
    public function store(StoreTaskRequest $request): JsonResponse
    {
        $task = $this->taskService->create(
            data: $request->validated(),
            userId: $request->user()->id,
        );

        return response()->json([
            'data' => new TaskResource($task),
            'message' => 'Task created successfully'
        ], 201);
    }


    public function update(UpdateTaskRequest $request, Task $task): TaskResource
    {
        $task = $this->taskService->update(
            task: $task,
            data: $request->validated(),
            authUserId: $request->user()->id,
        );

        return new TaskResource($task);
    }


    public function markDone(Request $request, Task $task): TaskResource
    {
        $task = $this->taskService->markDone(
            task: $task,
            authUserId: $request->user()->id,
        );

        return new TaskResource($task);
    }


    public function destroy(Request $request, Task $task): JsonResponse
    {
        $this->taskService->delete(
            task: $task,
            authUserId: $request->user()->id,
        );

        return response()->json(['message' => 'Task deleted successfully.']);
    }
}
