<?php

namespace App\Http\Controllers;

use App\Models\Job;
use App\Models\Application;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $user = $request->user();

        // 1. Data Stats (Contoh: Hitung lamaran user)
        // Pastikan Anda sudah punya tabel 'applications' atau hapus bagian ini jika belum
        $stats = [
            'applied' => 0, // Default 0 jika tabel belum siap
            'interviews' => 0,
        ];
        
        // Cek jika model Application ada, baru hitung
        if (class_exists(\App\Models\Application::class)) {
             $stats['applied'] = Application::where('user_id', $user->id)->count();
             $stats['interviews'] = Application::where('user_id', $user->id)->where('status', 'interview')->count();
        }

        // 2. Featured Jobs (Ambil 5 job random atau terbaru)
        $featuredJobs = Job::inRandomOrder()->take(5)->get();

        // 3. Recent Jobs (Ambil 10 job terbaru)
        $recentJobs = Job::latest()->take(10)->get();

        return response()->json([
            'user' => $user,
            'stats' => $stats,
            'featured_jobs' => $featuredJobs,
            'recent_jobs' => $recentJobs
        ]);
    }
}
