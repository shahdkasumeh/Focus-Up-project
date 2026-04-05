<?php

namespace App\Http\Controllers;

use App\Http\Requests\Booking\createBookingRequest;
use App\Http\Resources\BookingResource;
use App\Models\Booking;
use App\Services\BookingService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class BookingController extends Controller
{
    public function index()
    {
        $bookings = Booking::where('user_id', Auth::id())
            ->latest()
            ->get();

        return $this->success(
            BookingResource::collection($bookings)
        );
    }

    // إنشاء حجز
    public function store(createBookingRequest $request)
    {
        $booking = BookingService::createBooking(
            Auth::id(),
            $request->table_id,
            $request->room_id,
            $request->scheduled_start
        );

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // عرض حجز واحد
    public function show(Booking $booking)
    {
        $this->authorizeBooking($booking);

        $booking->load(['table.room', 'room']);

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // check-in (QR دخول)
    public function checkIn()
    {
        $booking =BookingService::checkIn(Auth::id());

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // check-out (QR خروج)
    public function checkOut()
    {
        $booking = BookingService::checkOut(Auth::id());

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // إلغاء الحجز
    public function cancel(Booking $booking)
    {
        $this->authorizeBooking($booking);

        $booking =BookingService::cancelBooking(
            $booking->id,
            Auth::id()
        );

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // حماية الوصول (user فقط)
    private function authorizeBooking(Booking $booking): void
    {
        if ($booking->user_id !== Auth::id()) {
            abort(403, 'Unauthorized');
        }
    }
}
