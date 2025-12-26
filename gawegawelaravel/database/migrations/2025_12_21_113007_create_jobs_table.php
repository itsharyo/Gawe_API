<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('jobs', function (Blueprint $table) {
            $table->id();
            
            // Relasi ke User (Company yang memposting)
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // Relasi ke Kategori (Opsional, jika pakai tabel kategori)
            // Jika tidak pakai tabel kategori, ganti jadi: $table->string('category');
            $table->foreignId('job_category_id')->nullable()->constrained('job_categories')->onDelete('set null');

            $table->string('title'); // Contoh: Senior Software Engineer
            $table->string('location'); // Contoh: Medan, Indonesia
            
            // Gaji (Sesuai gambar "$500 - $1,000")
            $table->string('salary_range'); 
            
            // Tipe Pekerjaan (Fulltime/Contract)
            $table->enum('type', ['Fulltime', 'Contract', 'Part-time', 'Freelance']);
            
            $table->text('description'); // Job Description
            $table->text('requirements'); // Requirements list
            
            $table->boolean('is_active')->default(true); // Status lowongan aktif/tutup
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('jobs');
    }
};