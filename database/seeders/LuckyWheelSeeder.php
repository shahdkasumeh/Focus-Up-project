<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\LuckyWheelAdmin;

class LuckyWheelSeeder extends Seeder
{
    public function run(): void
    {
        $prizes = [

            // =========================
            // خصومات
            // =========================

            [
                'name' => 'discount',
                'value' => '10',
                'probability' => 25,
            ],

            [
                'name' => 'discount',
                'value' => '20',
                'probability' => 15,
            ],

            [
                'name' => 'discount',
                'value' => '40',
                'probability' => 5,
            ],

            // =========================
            // رسائل
            // =========================

            [
                'name' => 'message',
                'value' => 'أنت طالب مجتهد استمر ',
                'probability' => 20,
            ],

            [
                'name' => 'message',
                'value' => 'النجاح يحتاج صبر ',
                'probability' => 15,
            ],

            // =========================
            // حظ أوفر
            // =========================

            [
                'name' => 'Better luck',
                'value' => 'حاول مرة أخرى ',
                'probability' => 10,
            ],

            // =========================
            // هدايا الإدارة
            // =========================

            [
                'name' => 'gift' ,
                'value' => 'قلم أزرق',
                'probability' => 5,
            ],

            [
                'name' => 'gift',
                'value' =>'دفتر سلك جامعي',
                'probability' => 5,
            ],
        ];

        foreach ($prizes as $prize) {

            LuckyWheelAdmin::create($prize);
        }
    }
}
