<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Buat Akun ADMIN
        User::create([
            'name' => 'Super Admin',
            'username' => 'admin',
            'email' => 'admin@gawe.com',
            'password' => bcrypt('admin123'), // Password Admin
            'role' => 'admin',       // Role khusus admin
            'status' => 'active',    // Admin harus langsung aktif
            'company_name' => '-',
            'company_registry_id' => 'ADMIN-001',
        ]);

        // 2. (Opsional) Buat Akun Company Dummy untuk Tes
        User::create([
            'name' => 'PT Testing Indonesia',
            'username' => 'pt_test',
            'email' => 'test@pt.com',
            'password' => bcrypt('123456'),
            'role' => 'company',
            'status' => 'pending', // Status pending biar bisa diverifikasi admin
            'company_name' => 'PT Testing Indonesia',
            'company_registry_id' => 'COMP-TEST-01',
        ]);
    }
}