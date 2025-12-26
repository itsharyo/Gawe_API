<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProfileController extends Controller
{
    // === SHOW PROFILE ===
    public function show(Request $request)
    {
        return response()->json($request->user());
    }

    // === UPDATE PROFILE (TERMASUK AVATAR & RESUME) ===
    public function update(Request $request)
    {
        $user = $request->user();

        // 1. Validasi Input
        $request->validate([
            'bio'       => 'nullable|string',
            'job_title' => 'nullable|string',
            'location'  => 'nullable|string',
            'skills'    => 'nullable|array', // Pastikan dikirim array dari Flutter
            'avatar'    => 'nullable|image|mimes:jpeg,png,jpg,gif|max:5120', // Max 5MB
            'resume'    => 'nullable|file|mimes:pdf,doc,docx|max:10240',    // Max 10MB
        ]);

        // 2. Update Data Teks
        if ($request->has('bio')) $user->bio = $request->bio;
        if ($request->has('job_title')) $user->job_title = $request->job_title;
        if ($request->has('location')) $user->location = $request->location;
        if ($request->has('skills')) $user->skills = $request->skills;

        // 3. Handle Upload Avatar (Foto Profil)
        if ($request->hasFile('avatar')) {
            // Hapus avatar lama jika ada
            if ($user->avatar && Storage::disk('public')->exists($user->avatar)) {
                Storage::disk('public')->delete($user->avatar);
            }
            
            // Simpan yang baru ke folder 'avatars' di storage public
            $path = $request->file('avatar')->store('avatars', 'public');
            $user->avatar = $path;
        }

        // 4. Handle Upload Resume
        if ($request->hasFile('resume')) {
            // Hapus resume lama jika ada
            if ($user->resume_path && Storage::disk('public')->exists($user->resume_path)) {
                Storage::disk('public')->delete($user->resume_path);
            }
            
            // Simpan file baru ke folder 'resumes' di storage public
            $path = $request->file('resume')->store('resumes', 'public');
            $user->resume_path = $path;
        }

        // 5. Simpan Perubahan
        $user->save();

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user
        ]);
    }

    // === DELETE RESUME (FITUR BARU) ===
    public function deleteResume(Request $request)
    {
        $user = $request->user();

        // Cek apakah user punya resume
        if ($user->resume_path) {
            
            // Hapus file fisik dari storage
            if (Storage::disk('public')->exists($user->resume_path)) {
                Storage::disk('public')->delete($user->resume_path);
            }
            
            // Set kolom di database menjadi NULL
            $user->resume_path = null;
            $user->save();

            return response()->json([
                'message' => 'Resume deleted successfully', 
                'user' => $user
            ]);
        }

        return response()->json(['message' => 'No resume to delete'], 400);
    }
}