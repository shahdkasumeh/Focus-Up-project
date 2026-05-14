<?php

namespace App\Http\Controllers;

use App\Http\Requests\LWAdminRequest;
use App\Http\Resources\LuckyWheelAdminResource;
use App\Models\LuckyWheelAdmin;
use App\Services\LuckyWheelAdminService;
use Illuminate\Http\Request;

class LuckyWheelAdminController extends Controller
{
    public function index(){
        return $this->success(
            LuckyWheelAdminResource::collection(
                LuckyWheelAdminService::query()->get()
                )
        );
    }

    public function show(LuckyWheelAdmin $luckyWheelAdmin){
        return $this->success(
            LuckyWheelAdminResource::make($luckyWheelAdmin)
        );
    }

    public function store(LWAdminRequest $lWAdminRequest){
        return $this->success(
            LuckyWheelAdminResource::make(
                LuckyWheelAdminService::create($lWAdminRequest->validated())
            )
        );
    }

    public function update(LWAdminRequest $lWAdminRequest,LuckyWheelAdmin $luckyWheelAdmin){
        return $this->success(
                LuckyWheelAdminResource::make(
                    LuckyWheelAdminService::update($lWAdminRequest->validated(),$luckyWheelAdmin)
                )
        );
    }

    public function destroy(LuckyWheelAdmin $luckyWh){
      LuckyWheelAdminService::delete($luckyWh);
        return $this->success('delete prize name successfully');
    }
}
