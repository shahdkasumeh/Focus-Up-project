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
        Schema::create('consumption_packages', function (Blueprint $table) {
            $table->id();

            // ربط الباقة بالمستخدم
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('package_id')->constrained()->cascadeOnDelete();


            // تاريخ بداية ونهاية الاشتراك
            $table->timestamp('starts_at')->nullable();
            $table->timestamp('expires_at')->nullable();



            // الساعات
            $table->decimal('total_hours', 8, 2)->default(0);
            $table->decimal('remaining_hours', 8, 2)->default(0);

            // السعر
            $table->decimal('total_price', 10, 2)->default(0);
            $table->decimal('remaining_price', 10, 2)->default(0);

            // الحالة
            $table->enum('status', ['pending', 'active', 'expired', 'cancelled'])
                ->default('pending');

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('consumption_packages');
    }
};
