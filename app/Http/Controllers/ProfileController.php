<?php

namespace App\Http\Controllers;

use App\Http\Requests\Profile\StoreProfileRequest;
use App\Http\Requests\Profile\UpdateProfileRequest;
use App\Http\Requests\Profile\UploadImageRequest;
use App\Http\Resources\ProfileResource;
use App\Services\ProfileService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    public function __construct(private readonly ProfileService $profileService)
    {
    }

    // GET /api/profile
    public function show(Request $request): ProfileResource
    {
        $profile = $this->profileService->getByUser(
            userId: $request->user()->id,
        );
        if (!$profile) {
            abort(404, 'Profile not found.');
        }
        return new ProfileResource($profile);
    }

    // POST /api/profile
    public function store(StoreProfileRequest $request): JsonResponse
    {
        $profile = $this->profileService->create(
            data: $request->validated(),
            userId: $request->user()->id,
        );

        return (new ProfileResource($profile))
            ->response()
            ->setStatusCode(201);
    }

    // PUT /api/profile
    public function update(UpdateProfileRequest $request): ProfileResource
    {
        $profile = $this->profileService->update(
            data: $request->validated(),
            userId: $request->user()->id,
        );

        return new ProfileResource($profile);
    }

    // POST /api/profile/image
    public function uploadImage(UploadImageRequest $request): ProfileResource
    {
        $profile = $this->profileService->uploadImage(
            file: $request->file('image'),
            userId: $request->user()->id,
        );

        return new ProfileResource($profile);
    }
}
