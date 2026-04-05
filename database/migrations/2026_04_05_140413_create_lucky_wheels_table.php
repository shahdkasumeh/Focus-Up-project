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

            $table->enum('prize_type', ['discount', 'motivational']);
            $table->decimal('discount_percent', 5, 2)->nullable();
            $table->string('message')->nullable();

            $table->boolean('is_used')->default(false);

            $table->foreignId('used_in_booking_id')
            ->nullable()
            ->constrained('bookings')
            ->nullOnDelete();
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
