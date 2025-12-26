<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class AdminController extends Controller
{
    // 1. LIHAT DAFTAR COMPANY YANG PENDING
    public function getPendingCompanies()
    {
        // Ambil semua user yang role-nya 'company' DAN status-nya 'pending'
        $companies = User::where('role', 'company')
                         ->where('status', 'pending')
                         ->get();

        return response()->json([
            'message' => 'List pending companies',
            'data' => $companies
        ]);
    }

    // 2. VERIFIKASI / APPROVE COMPANY
    public function verifyCompany($id)
    {
        $company = User::find($id);

        if (!$company) {
            return response()->json(['message' => 'Company not found'], 404);
        }

        // Ubah status jadi active
        $company->status = 'active';
        $company->save();

        return response()->json([
            'message' => 'Company has been verified and activated!',
            'data' => $company
        ]);
    }

    // 3. TOLAK / HAPUS COMPANY (Opsional)
    public function rejectCompany($id)
    {
        $company = User::find($id);
        
        if ($company) {
            $company->delete(); // Hapus data dari database
        }

        return response()->json(['message' => 'Company rejected and deleted.']);
    }
}