<?php

namespace App\Services;

use App\Models\Booking;
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
        $totalTables = $room->tables()->where('is_active', true)->count();

        if ($totalTables == 0)
            return 0;

        $occupiedTables = $room->tables()
            ->where('is_active', true)
            ->where('is_occupied', true)
            ->count();

        return round(($occupiedTables / $totalTables) * 100, 2);
    }

    public function getCurrentOccupancy(Room $room): int
    {
        return $room->tables()
            ->where('is_active', true)
            ->where('is_occupied', true)

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
            'social' => [
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
        $totalTables = $room->tables()->where('is_active', true)->count();
        $occupiedTables = $this->getCurrentOccupancy($room);
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
            'total_tables' => $totalTables,
            'occupied_tables' => $occupiedTables,
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

        public static function crowdingwalk(): array
{
        $room=Room::Where('type','social')->first();

        if(!$room){
        return[
            'error'=>'Room not found'
        ];
    }
        $capacity=$room->capacity;
    $currentInside = Booking::where('status', 'active')
    ->whereNull('scheduled_start')
    -> whereNull('scheduled_end')
    ->whereNull('actual_end')
        ->count();

    $percentage = $capacity > 0
        ? round(($currentInside / $capacity) * 100,2)
        : 0;

    $status = match (true) {
        $percentage < 50 => 'low',
        $percentage < 80 => 'medium',
        default => 'high',
    };

    $color = match (true) {
        $percentage < 50 => 'green',
        $percentage < 80 => 'yellow',
        default => 'red',
    };

    $message = match ($status) {
        'low' => 'القاعة هادئة',
        'medium' => 'إشغال متوسط',
        'high' => 'القاعة مزدحمة',
    };

    return [
        'capacity' => $capacity,
        'current_inside' => $currentInside,
        'crowding_percentage' => $percentage,
        'status' => $status,
        'color' => $color,
        'message' => $message
    ];
}






}
