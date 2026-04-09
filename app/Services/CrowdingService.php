<?php

namespace App\Services;

use App\Models\Room;

class CrowdingService
{
    /**
     * Create a new class instance.
     */
    public function __construct()
    {
        //
    }


    public function getCrowdingPercentage(Room $room): float
    {
        if ($room->capacity == 0)
            return 0;

        $currentOccupancy = $this->getCurrentOccupancy($room);

        return round(($currentOccupancy / $room->capacity) * 100, 2);
    }

    public function getCurrentOccupancy(Room $room): int
    {
        return $room->bookings()
            ->where('status', 'active')
            ->whereNotNull('actual_start')
            ->whereNull('actual_end')
            ->count();
    }

    public function getThresholds(string $type): array
    {
        return match ($type) {
            'quiet' => [
                'green' => 40,
                'yellow' => 70,
                'red' => 100,
                'green_msg' => 'القاعة هادئة حالياً ومناسبة للتركيز العالي.',
                'yellow_msg' => 'إشغال متوسط، يُفضل تأكيد الحجز.',
                'red_msg' => 'القاعة مزدحمة، يُنصح بالحضور بعد 30 دقيقة.',
            ],
            'social_smoking' => [
                'green' => 50,
                'yellow' => 75,
                'green_msg' => 'أجواء مريحة ومتاحة حالياً.',
                'yellow_msg' => 'إشغال متوسط، يُنصح بالحجز المسبق.',
                'red_msg' => 'ازدحام مرتفع، قد يصعب العثور على مقعد مباشر.',
            ],
            'social_no_smoking' => [
                'green' => 50,
                'yellow' => 80,
                'red' => 100,
                'green_msg' => 'متاحة ومناسبة للدراسة الجماعية.',
                'yellow_msg' => 'حركة طبيعية، يُفضل الحجز قبل الحضور.',
                'red_msg' => 'القاعة في وقت ذروة، يُنصح باختيار قاعة أخرى.',
            ],
            'discussion' => [
                'green' => 60,
                'yellow' => 85,
                'red' => 100,
                'green_msg' => 'متاحة للنقاش والعمل الجماعي.',
                'yellow_msg' => 'إشغال متوسط، يُفضل الحجز المسبق.',
                'red_msg' => 'القاعة ممتلئة، يُنصح باختيار قاعة أخرى.',
            ],
            default => [
                'green' => 50,
                'yellow' => 80,
                'green_msg' => 'متاح.',
                'yellow_msg' => 'إشغال متوسط.',
                'red_msg' => 'ازدحام مرتفع.',
            ],
        };
    }


    // جيب حالة الازدحام الكاملة للغرفة
    public function getCrowdingStatus(Room $room): array
    {
        $percentage = $this->getCrowdingPercentage($room);
        $occupancy = $this->getCurrentOccupancy($room);
        $thresholds = $this->getThresholds($room->type);

        if ($percentage <= $thresholds['green']) {
            $color = 'green';
            $status = 'low';
            $message = $thresholds['green_msg'];
        } elseif ($percentage <= $thresholds['yellow']) {
            $color = 'yellow';
            $status = 'medium';
            $message = $thresholds['yellow_msg'];
        } else {
            $color = 'red';
            $status = 'high';
            $message = $thresholds['red_msg'];
        }

        return [
            'room_id' => $room->id,
            'room_name' => $room->name,
            'room_type' => $room->type,
            'capacity' => $room->capacity,
            'current_occupancy' => $occupancy,
            'percentage' => $percentage,
            'color' => $color,
            'status' => $status,
            'message' => $message,
        ];
    }

    // جيب حالة كل الغرف
    public function getAllRoomsCrowding(): array
    {
        $rooms = Room::all();

        return $rooms->map(function ($room) {
            return $this->getCrowdingStatus($room);
        })->toArray();
    }


    public function actual_start(Room $room, int $bookingId): array
    {
        $booking = $room->bookings()
            ->where('id', $bookingId)

            ->whereNull('actual_start')
            ->first();
if (!$booking) {
            return ['error' => 'Booking not found or already checked in'];
        }

        $booking->update([
            'actual_start' => now(),
            'status' => 'active'
        ]);



        return $this->getCrowdingStatus($room);
    }

    // تسجيل خروج عبر QR
    public function actual_end(Room $room, int $bookingId): array
    {
        $booking = $room->bookings()
            ->where('id', $bookingId)
            ->where('status', 'active')
            ->whereNotNull('actual_start')
            ->whereNull('actual_end')
            ->first();

        if (!$booking) {
            return ['error' => 'Booking not found or already checked out'];
        }

        $booking->update([
            'actual_end' => now(),
            'status' => 'completed'
        ]);

        return $this->getCrowdingStatus($room);
    }
}
