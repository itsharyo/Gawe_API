<?php

namespace App\Models;

// Import library yang dibutuhkan
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * Atribut yang bisa diisi (Mass Assignable)
     */
    protected $fillable = [
        'name',
        'username',
        'email',
        'password',
        'role',                // seeker / company
        'company_registry_id', // ID perusahaan (jika company)
        'company_name',
        'avatar',
        
        // --- FIELD TAMBAHAN UNTUK PROFIL ---
        'job_title',   // Jabatan/Pekerjaan (misal: Engineer)
        'location',    // Lokasi (misal: Jakarta)
        'resume_path', // Path file resume PDF
        'bio',         // Deskripsi diri
        'skills',      // Keahlian (disimpan sebagai JSON)
        'profession',  // (Opsional, jika masih dipakai)
    ];

    /**
     * Atribut yang harus disembunyikan saat return JSON (biar aman)
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Konversi tipe data otomatis
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'skills' => 'array', // PENTING: Otomatis ubah JSON di db jadi Array di PHP
    ];

    // RELASI: Jika user adalah company, dia bisa memposting banyak Job
    public function jobs() {
        return $this->hasMany(Job::class, 'user_id');
    }

    // RELASI: Jika user adalah seeker, dia bisa melamar ke banyak Job
    public function applications() {
        return $this->hasMany(Application::class, 'user_id');
    }
}