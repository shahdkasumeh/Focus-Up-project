 <?php

use App\Http\Controllers\BookingController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\ConsumptionPackageController;
use App\Http\Controllers\CrowdingController;
use App\Http\Controllers\LikeController;
use App\Http\Controllers\LuckyWheelAdminController;
use App\Http\Controllers\LuckyWheelController;
use App\Http\Controllers\PackageController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\RoomController;
use App\Http\Controllers\TableController;
use App\Http\Controllers\TaskController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
require __DIR__.'/auth.php';

Route::middleware(['auth:sanctum'])->get('/user', function (Request $request) {
    return $request->user();
});

Route::middleware('auth:sanctum')->group(function (){

//الحجز
    Route::get('/bookings', [BookingController::class, 'indexUser']);
    Route::get('/bookings/managment', [BookingController::class, 'indexManagement']);
    Route::post('/bookings', [BookingController::class, 'store']);
    Route::get('/bookings/{booking}', [BookingController::class, 'show']);
    Route::post('/bookings/check_in', [BookingController::class, 'checkIn']);
    Route::post('/bookings/check_out', [BookingController::class, 'checkOut']);
    Route::post('/bookings/{booking}/cancel', [BookingController::class, 'cancel']);
    Route::get('/admin/bookings/status', [BookingController::class, 'status']);
    Route::get('/admin/bookings/last-week', [BookingController::class, 'lastWeekStats']);


    //الازدحام
    Route::get('/crowding/walkin', [CrowdingController::class, 'indexCrowding']);
    Route::get('/crowding',[CrowdingController::class,'index']);


    //الغرف
    Route::get('/rooms', [RoomController::class, 'index']);
    Route::get('/rooms/{room}', [RoomController::class, 'show']);


        //الطاولات
        Route::get('/tables/stats', [TableController::class, 'stats']);
        Route::get('/tables', [TableController::class, 'index']);
        Route::get('/tables/{table}', [TableController::class, 'show']);



         //الباقات
        Route::get('/packages', [PackageController::class, 'index']);
        Route::get('/package/{package}', [PackageController::class, 'show']);
        Route::get('/stats', [PackageController::class, 'stats']);

        //الباقات لطالب
        Route::get('/myPackage', [ConsumptionPackageController::class, 'index']);
        Route::post('/buy', [ConsumptionPackageController::class, 'store']);
        Route::get('/active', [ConsumptionPackageController::class, 'active']);



    //  الإعلانات
    Route::get('/posts', [PostController::class, 'index']);
    Route::get('/posts/my', [PostController::class, 'myPosts']);
    Route::post('/posts', [PostController::class, 'store']);
    Route::get('/posts/{post}', [PostController::class, 'show']);
    Route::put('/posts/{post}', [PostController::class, 'update']);
    Route::delete('/posts/{post}', [PostController::class, 'destroy']);

    // التعليقات
    Route::post('/posts/{post}/comments', [CommentController::class, 'store']);
    Route::put('/posts/{post}/comments/{comment}', [CommentController::class, 'update']);
    Route::delete('/posts/{post}/comments/{comment}', [CommentController::class, 'destroy']);

    // اللايك
    Route::post('/posts/{post}/like', [LikeController::class, 'toggle']);

    //المهام
        Route::prefix('tasks')->group(function(){
        Route::get('/', [TaskController::class, 'index']);
        Route::post('/', [TaskController::class, 'store']);
        Route::put('/{task}', [TaskController::class, 'update']);
        Route::patch('/{task}/done', [TaskController::class, 'markDone']);
        Route::delete('/{task}', [TaskController::class, 'destroy']);
        });

    //الملف الشخصي
       Route::prefix('profile')->group(function(){
        Route::get('/', [ProfileController::class, 'show']);
        Route::post('/', [ProfileController::class, 'store']);
        Route::put('/', [ProfileController::class, 'update']);
        Route::post('/image', [ProfileController::class, 'uploadImage']);
       });


        //العجلة
        Route::get('/getAllPrize',[LuckyWheelAdminController::class,'index']);
        Route::get('/getPrizeById/{luckyWheelAdmin}',[LuckyWheelAdminController::class,'show']);


    Route::get('/can-spin', [LuckyWheelController::class, 'canSpin']);
    Route::get('/prizes', [LuckyWheelController::class, 'prizes']);
    Route::post('/spin', [LuckyWheelController::class, 'spin']);
    Route::get('/wheel/my-prizesCurrent', [LuckyWheelController::class, 'myPrizesCurrent']);
    Route::get('/wheel/my-prizes', [LuckyWheelController::class, 'myPrizes']);
    Route::put('/claim-gift/{id}',[LuckyWheelController::class, 'claimGift']);
    Route::get('/wheel/gifts', [LuckyWheelController::class, 'gifts']);
        });

Route::middleware(['auth:sanctum', 'role:admin'])->group(function () {

    // Rooms CRUD
    Route::post('/rooms', [RoomController::class, 'store']);
    Route::put('/rooms/{room}', [RoomController::class, 'update']);
    Route::delete('/rooms/{room}', [RoomController::class, 'destroy']);

    // Tables CRUD
    Route::post('/tables', [TableController::class, 'store']);
    Route::put('/tables/{table}', [TableController::class, 'update']);
    Route::delete('/tables/{table}', [TableController::class, 'destroy']);

    // Packages
    Route::post('/packages', [PackageController::class, 'store']);
    Route::put('/packages/{package}', [PackageController::class, 'update']);
    Route::delete('/packages/{package}', [PackageController::class, 'destroy']);

    //lucky wheel
        Route::post('/createLuckyWheel',[LuckyWheelAdminController::class,'store']);
        Route::put('/updatePrize/{luckyWheelAdmin}',[LuckyWheelAdminController::class,'update']);
        Route::delete('/deletePrize/{luckyWh}',[LuckyWheelAdminController::class,'destroy']);

});
     Route::middleware(['auth:sanctum', 'role:receptionist'])->group(function () {
     Route::get('/pending', [ConsumptionPackageController::class, 'pending']);
      Route::put('/active/{id}', [ConsumptionPackageController::class, 'activeStatus']);

});
