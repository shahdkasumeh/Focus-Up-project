<?php

namespace App\Http\Controllers;

use App\Http\Requests\Table\TableRequest;
use App\Http\Resources\TableResource;
use App\Models\Table;
use App\Services\TableService;
use App\Traits\ResponseTrait;
// use Illuminate\Http\Request;

class TableController extends Controller
{
    use ResponseTrait;


    public function index()
    {
        return $this->success(
            TableResource::collection(
                TableService::query()->get()
            )
        );
    }
    public function store(TableRequest $request)
    {
        return $this->success(
            TableResource::make(
                TableService::create($request->validated())
            )
        );

    }
    public function show(Table $table)
    {
        return $this->success(

            TableResource::make($table)
        );
    }
    public function update(TableRequest $request, Table $table)
    {
        return TableResource::make(
            TableService::update($request->validated(), $table)
        );
    }
    public function destroy(Table $table)
    {
        TableService::delete($table);
        return $this->success('delete table successfuly');
    }
}
