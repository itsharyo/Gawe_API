<?php

// database/migrations/2024_01_01_000002_create_job_categories_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('job_categories', function (Blueprint $table) {
            $table->id();
            $table->string('name'); // Contoh: Programmer, UI/UX
            $table->string('slug')->unique(); // contoh: programmer
            $table->string('icon')->nullable(); // Jika ingin ada ikon kategori
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('job_categories');
    }
};
