<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('applications', function (Blueprint $table) {
            $table->id();
            
            // Relasi ke Pelamar (Seeker)
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // Relasi ke Pekerjaan yang dilamar
            $table->foreignId('job_id')->constrained('jobs')->onDelete('cascade');
            
            // Data input dari form Apply (Sesuai screenshot)
            $table->string('applicant_name'); // User Name di form
            $table->string('email');
            $table->string('phone_number');
            
            // File Resume/CV
            $table->string('resume_path'); // Path file PDF yang diupload
            
            // Status Lamaran
            $table->enum('status', ['pending', 'interview', 'accepted', 'rejected'])->default('pending');
            
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('applications');
    }
};
