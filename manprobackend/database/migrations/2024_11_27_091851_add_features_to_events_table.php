<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Buat tabel kategori
        Schema::create('event_categories', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('slug');
            $table->timestamps();
        });

        // Tambah kolom ke tabel events
        Schema::table('events', function (Blueprint $table) {
            $table->foreignId('category_id')->nullable()->constrained('event_categories');
            $table->enum('status', ['upcoming', 'ongoing', 'completed'])->default('upcoming');
            $table->integer('capacity')->default(0);
            $table->boolean('enable_reminder')->default(true);
            $table->timestamp('reminder_at')->nullable();
            $table->string('share_url')->nullable();
            $table->timestamp('registration_end_date')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('events', function (Blueprint $table) {
            $table->dropForeign(['category_id']);
            $table->dropColumn([
                'category_id',
                'status',
                'capacity',
                'enable_reminder',
                'reminder_at',
                'share_url',
                'registration_end_date'
            ]);
        });

        Schema::dropIfExists('event_categories');
    }
};