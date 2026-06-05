<?php

namespace App\Services;

use App\Models\Task;
use Illuminate\Support\Carbon;

class TaskService
{
    public function getByDate(int $userId, string $date)
    {
        return Task::where('user_id', $userId)
            ->whereDate('due_date', $date)
            ->orderBy('status')
            ->get();
    }

    public function create(array $data, int $userId): Task
    {
        return Task::create([
            'title' => $data['title'],
            'description' => $data['description'] ?? null,
            'status' => 'pending',
            'due_date' => $data['due_date'] ?? Carbon::today(),
            'user_id' => $userId,
        ]);
    }

    public function markDone(Task $task, int $authUserId): Task
    {
        abort_if(
            $task->user_id !== $authUserId,
            403,
            'You do not have permission.'
        );

        $task->update(['status' => 'done']);

        return $task->fresh();
    }

    public function update(Task $task, array $data, int $authUserId): Task
    {
        abort_if($task->user_id !== $authUserId, 403, 'No permission.');

        if (isset($data['title'])) {
            $task->title = $data['title'];
        }

        if (isset($data['description'])) {
            $task->description = $data['description'];
        }

        if (isset($data['due_date'])) {
            $task->due_date = $data['due_date'];
        }

        $task->save();

        return $task->fresh();
    }
    public function delete(Task $task, int $authUserId): void
    {
        abort_if(
            $task->user_id !== $authUserId,
            403,
            'You do not have permission.'
        );

        $task->delete();
    }
}
