<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Job extends Model
{
    use HasFactory;

    // Guarded kosong berarti semua kolom boleh diisi (alternatif dari fillable)
    protected $guarded = ['id'];

    // RELASI: Job ini milik satu Company (User)
    public function company() {
        return $this->belongsTo(User::class, 'user_id');
    }

    // RELASI: Job ini memiliki banyak pelamar (Applications)
    public function applications() {
        return $this->hasMany(Application::class);
    }
    
    // RELASI: (Opsional) Job punya satu kategori
    public function category() {
        return $this->belongsTo(JobCategory::class, 'job_category_id');
    }
}