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
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('table_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('room_id')->nullable()->constrained()->nullOnDelete();
            // وقت البدء المحدد من الطالب عند الحجز
            $table->timestamp('scheduled_start')->nullable();
            $table->timestamp('scheduled_end')->nullable();

            // أوقات الجلسة الفعلية (تُعبأ عند مسح QR)
            $table->timestamp('actual_start')->nullable();
            $table->timestamp('actual_end')->nullable();
            // النتائج (تُحسب عند QR الخروج)
            $table->decimal('hours', 8, 2)->nullable();
            $table->decimal('total_price', 10, 2)->nullable();
            $table->decimal('discount_percent', 5, 2)->default(0);
            $table->decimal('discount_amount', 10, 2)->default(0);

            $table->enum('status', [
                'pending',    // تم الحجز، لم يحن الوقت بعد
                'active',     // حان الوقت، الطاولة مشغولة (قبل أو بعد QR الدخول)
                'completed',  // انتهت الجلسة
                'cancelled',  // ملغى
                'no_show',    // حان الوقت ومضت ساعة بدون مسح QR
            ])->default('pending');
            $table->timestamps();

            // Index يسرّع استعلام الـ Scheduler
            $table->index(['status', 'scheduled_start'], 'idx_status_scheduled_start');

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};
