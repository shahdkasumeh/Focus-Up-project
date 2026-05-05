<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;


return new class extends Migration {

    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->enum('type', ['quiet', 'social_smoking', 'social_no_smoking', 'discussion', 'social']);
            $table->unsignedInteger('capacity');
            $table->boolean('is_active')->default(true);
            $table->boolean('is_occupied')->default(false);

            $table->enum('status', ['active', 'inactive'])->default('active');
            $table->timestamps();
        });

    }



    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rooms');
    }
};
