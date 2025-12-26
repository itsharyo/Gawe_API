<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Application extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'job_id',
        'applicant_name',
        'email',
        'phone_number',
        'resume_path',
        'status'
    ];

    // RELASI: Lamaran ini milik satu User (Pelamar)
    public function user() {
        return $this->belongsTo(User::class);
    }

    // RELASI: Lamaran ini tertuju pada satu Job
    public function job() {
        return $this->belongsTo(Job::class);
    }
}