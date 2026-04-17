<?php

use App\Http\Controllers\BookingController;
use App\Http\Controllers\CrowdingController;
use App\Http\Controllers\PackageController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\TableController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
require __DIR__.'/auth.php';

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->group(function (){

    Route::apiResource('packages',PackageController::class);

    //الحجز
    Route::get('/bookings', [BookingController::class, 'indexUser']);
    Route::get('/bookings/managment', [BookingController::class, 'indexManagement']);
    Route::post('/bookings', [BookingController::class, 'store']);
    Route::get('/bookings/{booking}', [BookingController::class, 'show']);
    Route::post('/bookings/check_in', [BookingController::class, 'checkIn']);
    Route::post('/bookings/check_out', [BookingController::class, 'checkOut']);
    Route::post('/bookings/{booking}/cancel', [BookingController::class, 'cancel']);
    Route::get('/admin/bookings/stats', [BookingController::class, 'stats']);
    Route::get('/admin/bookings/last-week', [BookingController::class, 'lastWeekStats']);


    //الازدحام
    Route::get('/crowding/first-four', [CrowdingController::class, 'firstFourBookingCrowding']);
    Route::get('/crowding/walkin', [CrowdingController::class, 'indexCrowding']);
    Route::get('/crowding',[CrowdingController::class,'index']);
    Route::get('/crowding/{rooms}',[CrowdingController::class,'show']);

    //الغرف
    Route::get('/rooms', [RoomController::class, 'index'])
        ->middleware('can:room.index');

    Route::post('/rooms', [RoomController::class, 'store'])
        ->middleware('can:room.create');

    Route::get('/rooms/{room}', [RoomController::class, 'show'])
        ->middleware('can:room.show');

    Route::put('/rooms/{room}', [RoomController::class, 'update'])
        ->middleware('can:room.update');

    Route::delete('/rooms/{room}', [RoomController::class, 'destroy']);
        //->middleware('can:room.delete');


        //الطاولات
        Route::get('/tables/stats', [TableController::class, 'stats']);
    Route::get('/tables', [TableController::class, 'index'])
        ->middleware('can:table.index');

    Route::post('/tables', [TableController::class, 'store'])
        ->middleware('can:table.create');

    Route::get('/tables/{table}', [TableController::class, 'show'])
        ->middleware('can:table.show');

    Route::put('/tables/{table}', [TableController::class, 'update']);
       // ->middleware('can:table.update');

    Route::delete('/tables/{table}', [TableController::class, 'destroy'])
        ->middleware('can:table.delete');

});


