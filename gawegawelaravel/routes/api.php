<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

// IMPORT WAJIB AGAR MAGIC ROUTE TIDAK ERROR
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;

// Import Controllers
use App\Http\Controllers\AuthController;
use App\Http\Controllers\JobController;
use App\Http\Controllers\ApplicationController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

// ========================================================================
// 1. MAGIC ROUTE (FIX AKUN COMPANY & DATABASE)
// Akses ini lewat browser: http://localhost:8000/api/super-fix
// ========================================================================
Route::get('/super-fix', function () {
    // 1. PERBAIKI STRUKTUR DATABASE (Tambah kolom status jika hilang)
    if (!Schema::hasColumn('users', 'status')) {
        Schema::table('users', function (Blueprint $table) {
            $table->string('status')->default('active')->after('role');
        });
    }

    // 2. BERSIHKAN DATA LAMA
    User::where('username', 'pt_test')->delete();
    User::where('email', 'test@pt.com')->delete();

    // 3. BUAT USER BARU (PASTI ACTIVE)
    try {
        $user = User::create([
            'name' => 'PT Testing Indonesia',
            'username' => 'pt_test',       
            'email' => 'test@pt.com',      
            'password' => Hash::make('123456'), 
            'role' => 'company',
            'status' => 'active',          // <--- PENTING
            'company_name' => 'PT Testing Indonesia',
            'company_registry_id' => 'COMP-TEST-01', 
        ]);
        
        return response()->json([
            'message' => 'SUKSES! Database diperbaiki & User dibuat.',
            'status_column' => 'Added (or already exists)',
            'user_created' => $user
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'message' => 'GAGAL!',
            'error' => $e->getMessage()
        ], 500);
    }
});

// ========================================================================
// 2. PUBLIC ROUTES (Tidak butuh Token)
// ========================================================================
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::get('/jobs', [JobController::class, 'index']); // Lihat job tanpa login
Route::get('/jobs/{id}', [JobController::class, 'show']);

// ========================================================================
// 3. PROTECTED ROUTES (Butuh Login / Token)
// ========================================================================
Route::middleware('auth:sanctum')->group(function () {
    
    // Auth Actions
    Route::post('/logout', [AuthController::class, 'logout']);
    
    // Dashboard
    Route::get('/dashboard', [DashboardController::class, 'index']);

    // Profile
    Route::get('/profile', [ProfileController::class, 'show']);
    Route::post('/profile/update', [ProfileController::class, 'update']); // Update data + avatar
    Route::post('/profile/delete-resume', [ProfileController::class, 'deleteResume']); // <--- BARU: Route Hapus Resume

    // Job Actions (Company Only)
    Route::post('/jobs', [JobController::class, 'store']); 
    
    // Apply Actions (Job Seeker Only)
    Route::post('/jobs/{id}/apply', [ApplicationController::class, 'apply']);
    Route::get('/my-applications', [ApplicationController::class, 'myApplications']);

    // --- ADMIN ROUTES ---
    Route::get('/admin/pending-companies', [AdminController::class, 'getPendingCompanies']);
    Route::post('/admin/verify-company/{id}', [AdminController::class, 'verifyCompany']);
    Route::post('/admin/reject-company/{id}', [AdminController::class, 'rejectCompany']);
});