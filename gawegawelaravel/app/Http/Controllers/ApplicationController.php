<?php

namespace App\Http\Controllers;

use App\Models\Job;
use App\Models\Application;
use Illuminate\Http\Request;

class ApplicationController extends Controller
{
    // Apply Job
    public function apply(Request $request, $jobId)
    {
        $request->validate([
            'email' => 'required|email',
            'phone' => 'required', // Sesuaikan dengan nama kolom di database (phone atau phone_number)
            'resume' => 'required|mimes:pdf,doc,docx|max:2048' // Upload file max 2MB
        ]);

        $job = Job::find($jobId);
        if (!$job) return response()->json(['message' => 'Job not found'], 404);

        // Handle File Upload
        $path = null;
        if ($request->hasFile('resume')) {
            // Simpan di folder storage/app/public/resumes
            $path = $request->file('resume')->store('resumes', 'public');
        }

        // Simpan Data Lamaran
        $application = Application::create([
            'user_id' => $request->user()->id,
            'job_id' => $jobId,
            'email' => $request->email,
            'phone_number' => $request->phone, // Sesuaikan kolom db
            'applicant_name' => $request->user()->name, // Ambil nama dari user yang login
            'resume_path' => $path,
            'status' => 'pending'
        ]);

        return response()->json([
            'message' => 'Application sent successfully!',
            'data' => $application
        ]);
    }
    
    // User melihat histori lamaran
    public function myApplications(Request $request) {
        $applications = Application::with('job.company')
                        ->where('user_id', $request->user()->id)
                        ->latest()
                        ->get();
                        
        return response()->json(['data' => $applications]);
    }
}