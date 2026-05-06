<?php

namespace App\Http\Controllers;

use App\Http\Requests\Package\CreatePackageRequest;
use App\Http\Requests\Package\UpdatePackageRequest;
use App\Http\Resources\PackageResource;
use App\Models\Package;
use App\Services\PackageService;

class PackageController extends Controller
{

    public function index()
    {
            return $this->success(
            PackageResource::collection(
                PackageService::query()->get()
            )
        );
    }
    public function store(CreatePackageRequest $request)
    {
        return $this->success(
            PackageResource::make(
                PackageService::create($request->validated())
            )
        );

    }
    public function show(Package $package)
    {
        return $this->success(

            PackageResource::make($package)
        );
    }
    public function update(UpdatePackageRequest $request,Package $package)
    {
            return PackageResource::make(
                PackageService::update($request->validated(), $package)
    );
    }
    public function destroy(Package $package)
    {
        PackageService::delete($package);
            return $this->success('delete table successfuly');
    }
    public function stats()
    {
        return $this->success(
            PackageService::stats()
        );
    }

    }

