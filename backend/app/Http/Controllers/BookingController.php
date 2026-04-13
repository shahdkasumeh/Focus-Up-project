<?php

namespace App\Http\Controllers;

use App\Http\Requests\Booking\CreateBookingRequest;
use App\Http\Resources\BookingResource;
use App\Http\Resources\ManagmentBookingResource;
use App\Models\Booking;
use App\Services\BookingService;
use App\Traits\ResponseTrait;
use Illuminate\Support\Facades\Auth;

class BookingController extends Controller
{

    use ResponseTrait;
    // =========================================================
    // 1. List user bookings
    // =========================================================
    public function indexUser()
    {
        $bookings = Booking::where('user_id', Auth::id())
            ->latest()
            ->get();

        return $this->success(
            BookingResource::collection($bookings)
        );
    }

    public function indexManagement()
    {
        $bookings=Booking::with(['user','table','room'])
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
    public function checkIn()
    {
        $booking = BookingService::checkIn(Auth::id());

        return $this->success(
            BookingResource::make($booking)
        );
    }

    // =========================================================
    // 5. QR Check-out (end session)
    // =========================================================
    public function checkOut()
    {
        $booking = BookingService::checkOut(Auth::id());

        return $this->success(
            BookingResource::make($booking)
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

    // =========================================================
    // 7. Walk-in (QR direct entry)
    // =========================================================
    // public function walkIn()
    // {
    //     // إذا QR واحد فقط → المستخدم يختار من الفرونت أو من QR payload
    //     $booking = BookingService::walkIn(
    //         Auth::id(),
    //         request('table_id'),
    //         request('room_id')
    //     );

    //     return $this->success(
    //         BookingResource::make($booking)
    //     );
    // }

    // =========================================================
    // Authorization helper
    // =========================================================
    private function authorizeBooking(Booking $booking): void
    {
        if ($booking->user_id !== Auth::id()) {
            abort(403, 'Unauthorized');
        }
    }
}
