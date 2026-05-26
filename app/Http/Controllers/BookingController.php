<?php

namespace App\Http\Controllers;

use App\Http\Requests\Booking\CreateBookingRequest;
use App\Http\Resources\BookingResource;
use App\Http\Resources\ManagmentBookingResource;
use App\Models\Booking;
use App\Services\BookingService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class BookingController extends Controller
{
    // =========================================================
    // 1. List user bookings
    // =========================================================
    public function indexUser()
    {
        $bookings = Booking::with('table')->where('user_id', Auth::id())
            ->latest()
            ->get();

        return $this->success(
            BookingResource::collection($bookings)
        );
    }

    public function indexManagement()
    {
        $bookings=Booking::with(['user','table'])
        ->latest()
        ->get();
        return $this->success(
            ManagmentBookingResource::collection($bookings)
        );

    }



    // =========================================================
    // 2. Create scheduled booking
    // =========================================================
    public function store(CreateBookingRequest $request)
    {
        $booking = BookingService::createBooking(
            Auth::id(),
            $request->table_id,
            $request->room_id,
            $request->scheduled_start,
            $request->scheduled_end
        );

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // =========================================================
    // 3. Show single booking
    // =========================================================
    public function show(Booking $booking)
    {
        $this->authorizeBooking($booking);

        $booking->load(['table', 'room']);

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // =========================================================
    // 4. QR Check-in (scheduled booking)
    // =========================================================
    public function checkIn(Request $request)
{
    return $this->success(
        BookingResource::make(
            BookingService::checkIn(
                Auth::id(),
                $request->input('booking_id')
            )
        )
    );
}



    // =========================================================
    // 5. QR Check-out (end session)
    // =========================================================
    public function checkOut(Request $request)
{
    return $this->success(
        BookingResource::make(
            BookingService::checkOut(
                Auth::id(),
                $request->input('booking_id')
            )
        )
    );
}

    // =========================================================
    // 6. Cancel booking
    // =========================================================
    public function cancel(Booking $booking)
    {
        $this->authorizeBooking($booking);

        $booking = BookingService::cancelBooking(
            $booking->id,
            Auth::id()
        );

        return $this->success(
            BookingResource::make($booking)
        );
    }
    private function authorizeBooking(Booking $booking): void
    {
        if ($booking->user_id !== Auth::id()) {
            abort(403, 'Unauthorized');
        }
    }
    public function status()
{
    return $this->success(
        BookingService::getFullBookingStatus()
    );
}

public function lastWeekStats()
{
    return $this->success([
        'bookings' => BookingService::lastWeekBookingsCount(),
        'revenue'  => BookingService::lastWeekRevenue(),
    ]);
}

}
