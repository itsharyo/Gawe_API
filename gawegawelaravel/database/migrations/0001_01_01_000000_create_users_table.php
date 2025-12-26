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
        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('username')->unique()->nullable(); // Asumsi username nullable/unik
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('role')->default('seeker'); // seeker / company
            
            // Kolom Perusahaan
            $table->string('company_registry_id')->nullable();
            $table->string('company_name')->nullable();
            
            // Kolom Profil Tambahan (YANG HILANG KITA MASUKKAN SINI)
            $table->string('avatar')->nullable();
            $table->string('job_title')->nullable();   // <--- INI PENTING
            $table->string('location')->nullable();    // <--- INI PENTING
            $table->string('resume_path')->nullable(); // <--- INI PENTING
            $table->text('bio')->nullable();
            $table->string('profession')->nullable();
            $table->json('skills')->nullable();

            $table->rememberToken();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('users');
    }
};