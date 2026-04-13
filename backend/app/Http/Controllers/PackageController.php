<?php

namespace App\Http\Controllers;

use App\Http\Requests\Package\CreatePackageRequest;
use App\Http\Requests\Package\UpdatePackageRequest;
use App\Http\Resources\PackageResource;
use App\Models\Package;
use App\Services\PackageService;
use App\Traits\ResponseTrait;
use Illuminate\Http\Request;

class PackageController extends Controller
{
    use ResponseTrait;

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return $this->success(
            PackageResource::collection(
                PackageService::query()->where('status', 'active')->get()
            )
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(CreatePackageRequest $request)
    {
        return $this->success(
            PackageResource::make(
                PackageService::create($request->validated())
            )
        );
    }

    /**
     * Display the specified resource.
     */
    public function show(Package $package)
    {
        return $this->success(
            PackageResource::make($package)
        );
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdatePackageRequest $request, Package $package)
    {
        return PackageResource::make(
            PackageService::update($request->validated(), $package)
        );
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Package $package)
    {
        PackageService::delete($package);
        return $this->success('delete room successfuly');
    }
}
