<?php

namespace App\Http\Controllers;

use App\Models\Job;
use Illuminate\Http\Request;

class JobController extends Controller
{
    // Get All Jobs (Home Page & Search)
    public function index(Request $request)
    {
        // Load data job beserta data perusahaannya
        $query = Job::with('company'); 

        // Fitur Search (Berdasarkan Title atau Location)
        if ($request->has('search')) {
            $query->where('title', 'like', '%' . $request->search . '%')
                  ->orWhere('location', 'like', '%' . $request->search . '%');
        }

        // Fitur Filter Category
        if ($request->has('category')) {
            $query->where('category', $request->category); // Pastikan kolom category ada di tabel jobs
        }

        // Tampilkan job terbaru dulu
        $jobs = $query->latest()->get();

        return response()->json([
            'message' => 'List of jobs',
            'data' => $jobs
        ]);
    }

    // Get Job Detail
    public function show($id)
    {
        $job = Job::with('company')->find($id);

        if (!$job) {
            return response()->json(['message' => 'Job not found'], 404);
        }

        return response()->json([
            'message' => 'Job detail',
            'data' => $job
        ]);
    }

    // Create Job (Khusus Company)
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'category' => 'required', // Atau job_category_id jika pakai relasi
            'salary_range' => 'required',
            'description' => 'required',
            'location' => 'required',
            'type' => 'required'
        ]);

        // Pastikan yang post adalah company
        if ($request->user()->role !== 'company') {
            return response()->json(['message' => 'Only companies can post jobs'], 403);
        }

        // Create job via relasi user->jobs()
        $job = $request->user()->jobs()->create($request->all());

        return response()->json(['message' => 'Job posted successfully', 'data' => $job]);
    }
}