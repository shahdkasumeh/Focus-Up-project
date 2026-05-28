<?php

namespace App\Services;

use App\Models\Profile;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class ProfileService
{
    public function getByUser(int $userId): ?Profile
    {
        return Profile::with('user')
            ->where('user_id', $userId)
            // ->firstOrFail();
            ->first();
    }

    public function create(array $data, int $userId): Profile
    {
        abort_if(
            Profile::where('user_id', $userId)->exists(),
            422,
            'Profile already exists.'
        );

        $profile = Profile::create([
            'address' => $data['address'] ?? null,
            'birth_date' => $data['birth_date'],
            'gender' => $data['gender'],
            'study_level' => $data['study_level'],
            // 'has_discount' => false,
            'user_id' => $userId,
        ]);
        return $profile->load('user');
    }

    public function update(array $data, int $userId): Profile
    {
        $profile = Profile::where('user_id', $userId)->firstOrFail();

        $profile->update(array_filter($data, fn($v) => !is_null($v)));

        return $profile->fresh('user');
    }

    public function uploadImage(UploadedFile $file, int $userId): Profile
    {
        $profile = Profile::where('user_id', $userId)->firstOrFail();

        if ($profile->image) {
            Storage::disk('public')->delete($profile->image);
        }

        $path = $file->store('profiles', 'public');

        $profile->update(['image' => $path]);

        return $profile->fresh('user');
    }
}
