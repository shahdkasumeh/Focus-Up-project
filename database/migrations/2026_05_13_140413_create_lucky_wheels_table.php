<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('lucky_wheels', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('lucky_wheel_admin_id')->constrained()->cascadeOnDelete();

            $table->string('name');
            $table->string("value");


            $table->boolean('is_used')->default(false);

            $table->foreignId('used_in_booking_id')
            ->nullable()
            ->constrained('bookings')
            ->nullOnDelete();
            $table->timestamp('spun_at');
            $table->date('eligible_week_start');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lucky_wheels');
    }
};
