<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log; // PENTING: Untuk mencatat error ke file log

class AuthController extends Controller
{
    // ========================================================================
    // REGISTER
    // ========================================================================
    public function register(Request $request)
    {
        // 1. Validasi Input
        $request->validate([
            'username' => 'required|string|unique:users,username',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|min:6',
            'role' => 'required|in:seeker,company',
            'company_id' => 'nullable|required_if:role,company|string|unique:users,company_registry_id' 
        ]);

        // 2. Tentukan Status Awal
        // Company = pending (tunggu admin), Seeker = active (langsung masuk)
        $statusAccount = ($request->role === 'company') ? 'pending' : 'active';

        // 3. Simpan ke Database
        $user = User::create([
            'name' => $request->username,
            'username' => $request->username,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'role' => $request->role,
            'company_registry_id' => $request->company_id ?? null,
            'company_name' => $request->company_name ?? null,
            'status' => $statusAccount, // Simpan status
        ]);

        // 4. Buat Token
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Register success',
            'data' => $user,
            'access_token' => $token,
            'token_type' => 'Bearer'
        ], 201);
    }

    // ========================================================================
    // LOGIN (DENGAN "CCTV" / LOGGING LENGKAP)
    // ========================================================================
    public function login(Request $request)
    {
        // 1. CATAT DATA YANG DIKIRIM DARI FLUTTER (Cek di storage/logs/laravel.log)
        Log::info('---------------- LOGIN ATTEMPT ----------------');
        Log::info('Data dari Flutter:', $request->all());

        // 2. Validasi
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
            'role' => 'required|in:seeker,company',
            'company_id' => 'nullable|string'
        ]);

        // 3. CARI USER (Bisa pakai Username atau Email)
        $user = User::where('username', $request->username)
                    ->orWhere('email', $request->username)
                    ->first();

        // --- CEK 1: USER KETEMU? ---
        if (!$user) {
            Log::error('GAGAL: User tidak ditemukan di database.');
            return response()->json(['message' => 'User tidak ditemukan'], 401);
        }
        
        Log::info('User Ditemukan:', [
            'id' => $user->id, 
            'username' => $user->username, 
            'role_db' => $user->role, 
            'company_id_db' => $user->company_registry_id,
            'status' => $user->status
        ]);

        // --- CEK 2: PASSWORD BENAR? ---
        if (!Hash::check($request->password, $user->password)) {
            Log::error('GAGAL: Password Salah.');
            return response()->json(['message' => 'Password Salah'], 401);
        }

        // --- CEK 3: STATUS ACTIVE? ---
        if ($user->status == 'pending') {
            Log::error('GAGAL: Status akun masih PENDING.');
            return response()->json(['message' => 'Akun belum aktif (Pending)'], 403);
        }

        // --- CEK 4: ROLE COCOK? ---
        if ($user->role !== $request->role) {
            Log::error("GAGAL: Role tidak cocok. DB: {$user->role}, Input: {$request->role}");
            return response()->json(['message' => 'Role tidak sesuai'], 403);
        }

        // --- CEK 5: COMPANY ID COCOK? (Khusus Company) ---
        if ($request->role === 'company') {
            // Trim spasi agar perbandingan fair
            $dbId = trim($user->company_registry_id ?? '');
            $inputId = trim($request->company_id ?? '');

            Log::info("Pengecekan ID Perusahaan -> DB: '$dbId' vs Input: '$inputId'");

            if ($dbId !== $inputId) {
                Log::error('GAGAL: Company ID tidak cocok.');
                return response()->json(['message' => 'Company ID Salah'], 401);
            }
        }

        // --- SUKSES ---
        Log::info('BERHASIL: Login Sukses, Token Dibuat.');
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Login success',
            'data' => $user,
            'access_token' => $token,
            'token_type' => 'Bearer'
        ], 200);
    }

    // ========================================================================
    // LOGOUT
    // ========================================================================
    public function logout(Request $request) {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['message' => 'Logged out successfully']);
    }
}