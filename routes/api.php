<?php

use App\Http\Controllers\BookingController;
use App\Http\Controllers\CrowdingController;
use App\Http\Controllers\PackageController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\TableController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\LikeController;


use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
require __DIR__ . '/auth.php';

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('packages', PackageController::class);

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




    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/crowding', [CrowdingController::class, 'index']);
        Route::get('/crowding/{room}', [CrowdingController::class, 'show']);
        Route::post('/crowding/{room}/actual_start', [CrowdingController::class, 'actual_start']);
        Route::post('/crowding/{room}/actual_end', [CrowdingController::class, 'actual_end']);
        // بدون حجز
        Route::get('/crowding/walkin', [CrowdingController::class, 'indexCrowding']);



    });
    //الغرف
    // Route::get('/rooms', [RoomController::class, 'indexFour']);

    Route::get('/rooms', [RoomController::class, 'index'])
        ->middleware('can:room.index');

    Route::post('/rooms', [RoomController::class, 'store'])
        ->middleware('can:room.create');

    Route::get('/rooms/{room}', [RoomController::class, 'show'])
        ->middleware('can:room.show');

    Route::put('/rooms/{room}', [RoomController::class, 'update'])
        ->middleware('can:room.update');

    Route::delete('/rooms/{room}', [RoomController::class, 'destroy'])
        ->middleware('can:room.delete');
    // الطاولات
    Route::get('/tables', [TableController::class, 'index'])
        ->middleware('can:table.index');

    Route::post('/tables', [TableController::class, 'store'])
        ->middleware('can:table.create');

    Route::get('/tables/{table}', [TableController::class, 'show'])
        ->middleware('can:table.show');

    Route::put('/tables/{table}', [TableController::class, 'update'])
        ->middleware('can:table.update');

    Route::delete('/tables/{table}', [TableController::class, 'destroy'])
        ->middleware('can:table.delete');
});




Route::middleware('auth:sanctum')->group(function () {

    // Routes الإعلانات
    Route::get('/posts', [PostController::class, 'index']);          // عرض كل الإعلانات
    Route::get('/posts/my', [PostController::class, 'myPosts']);     // إعلاناتي فقط
    Route::post('/posts', [PostController::class, 'store']);         // إنشاء إعلان جديد
    Route::get('/posts/{post}', [PostController::class, 'show']);    // عرض إعلان مع تفاصيله
    Route::put('/posts/{post}', [PostController::class, 'update']);  // تعديل إعلان
    Route::delete('/posts/{post}', [PostController::class, 'destroy']); // حذف إعلان

    // ✅ Routes التعليقات
    Route::post('/posts/{post}/comments', [CommentController::class, 'store']);
    Route::put('/posts/{post}/comments/{comment}', [CommentController::class, 'update']);
    Route::delete('/posts/{post}/comments/{comment}', [CommentController::class, 'destroy']);

    // ✅ Route اللايك
    Route::post('/posts/{post}/like', [LikeController::class, 'toggle']);
});

