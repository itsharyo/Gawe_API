// lib/features/resume/screens/upload_resume_form_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Pastikan sudah di add: flutter pub add file_picker
import 'package:dotted_border/dotted_border.dart'; // Pastikan sudah di add: flutter pub add dotted_border
import '../../../services/api_service.dart'; // Sesuaikan path import ini

class UploadResumeFormScreen extends StatefulWidget {
  const UploadResumeFormScreen({super.key});

  @override
  State<UploadResumeFormScreen> createState() => _UploadResumeFormScreenState();
}

class _UploadResumeFormScreenState extends State<UploadResumeFormScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  File? _selectedFile;
  bool _isLoading = false;

  @override
  void dispose() {
    _jobTitleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // --- FUNGSI PILIH FILE ---
  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
        print("File Selected: ${_selectedFile!.path}");
      } else {
        print("User canceled file picking");
      }
    } catch (e) {
      print("Error picking file: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking file: $e")),
        );
      }
    }
  }

  // --- FUNGSI UPLOAD ---
  void _handleUpload() async {
    // 1. Validasi Minimal ada File atau Job Title
    if (_selectedFile == null && _jobTitleController.text.trim().isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please select a file or fill job title")),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    // 2. Panggil API Update Profile
    bool success = await ApiService.updateProfile(
      jobTitle: _jobTitleController.text.trim(),
      location: _locationController.text.trim(),
      resumeFile: _selectedFile,
    );

    // 3. Cek mounted sebelum update UI
    if (!mounted) return;

    setState(() => _isLoading = false);

    if (success) {
      Navigator.pop(context, true); // Kembali ke profile dan trigger refresh
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resume Uploaded Successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Upload Failed. Check connection or file size.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color colorPrimaryButton = const Color(0xFF8D3CFF);
    final Color colorPurpleText = const Color(0xFF6A26C4);
    final Color colorGreyText = Colors.grey[600]!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Resume",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Handle bar
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),

            // Icon Header
            Image.asset(
              'assets/images/upload_resume_icon.png',
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.upload_file, size: 80, color: colorGreyText);
              },
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              "Upload your resume",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorPurpleText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Adding your resume allows you to apply very\nquickly to many jobs from any device",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: colorGreyText, height: 1.4),
            ),
            const SizedBox(height: 24),

            // === AREA UPLOAD FILE (DIPERBAIKI) ===
            GestureDetector(
              onTap: _pickFile, // <--- HUBUNGKAN KE FUNGSI PICK FILE
              child: DottedBorder(
                color: colorPrimaryButton.withOpacity(0.7),
                strokeWidth: 1.5,
                dashPattern: const [6, 4],
                borderType: BorderType.RRect,
                radius: const Radius.circular(12.0),
                padding: EdgeInsets.zero,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F4FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Tampilkan nama file jika sudah dipilih
                      if (_selectedFile != null) ...[
                        Icon(Icons.description,
                            color: colorPrimaryButton, size: 40),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            _selectedFile!.path.split('/').last,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colorPurpleText,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text("(Tap to change)",
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ] else ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "+ Upload Resume",
                              style: TextStyle(
                                color: colorPurpleText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(Icons.upload_rounded,
                                color: colorPrimaryButton),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // === FORM INPUT ===
            _buildFormLabel("Your job title or qualification"),
            _buildTextField("Engineer, Designer, etc.", _jobTitleController),

            const SizedBox(height: 16),

            _buildFormLabel("Your location"),
            _buildTextField("Town, city, or country", _locationController),

            const SizedBox(height: 32),

            // === TOMBOL ACTION ===
            // Tombol Upload (Save)
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(color: colorPrimaryButton))
                  : ElevatedButton(
                      onPressed:
                          _handleUpload, // <--- HUBUNGKAN KE FUNGSI UPLOAD
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorPrimaryButton,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      child: const Text(
                        "Upload & Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
            ),

            const SizedBox(height: 12),

            // Tombol Cancel
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorPrimaryButton,
                  side: BorderSide(color: colorPrimaryButton, width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: label,
              style: const TextStyle(color: Colors.black87),
              children: const [
                TextSpan(
                    text: " *",
                    style: TextStyle(color: Colors.red, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller, // <--- Controller dipasang
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
}
