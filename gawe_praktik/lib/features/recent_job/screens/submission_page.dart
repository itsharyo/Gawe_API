import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import File Picker
import '../../../services/api_service.dart'; // Import ApiService

class SubmissionPage extends StatefulWidget {
  final Color primaryColor;
  final String jobId; // ID Pekerjaan yang dilamar

  const SubmissionPage({
    required this.primaryColor,
    required this.jobId,
    super.key,
  });

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage> {
  // Controller input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? _selectedFile; // Menyimpan file resume
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Fungsi Pilih File (CV/Resume)
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  // Fungsi Submit ke API
  void _handleSubmit() async {
    // Validasi Input
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Validasi File (Jika backend mewajibkan resume)
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your Resume/CV')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Panggil API
    bool success = await ApiService.applyJob(
      jobId: widget.jobId,
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      resumeFile: _selectedFile,
    );

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        Navigator.pop(context); // Tutup Modal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Application Sent Successfully!'),
            backgroundColor: widget.primaryColor,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to apply. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        // Tambahkan ScrollView agar aman saat keyboard muncul
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle drag
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),

            Text(
              "Apply for Job",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.primaryColor),
            ),
            const SizedBox(height: 20),

            // Input User Name
            _buildTextField(
              widget.primaryColor,
              label: 'User Name',
              controller: _nameController,
            ),
            const SizedBox(height: 20),

            // Input Email Address
            _buildTextField(
              widget.primaryColor,
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
            ),
            const SizedBox(height: 20),

            // Input Phone Number
            _buildTextField(
              widget.primaryColor,
              label: 'Phone number',
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
            const SizedBox(height: 20),

            // Upload Resume UI
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade50),
                child: Row(
                  children: [
                    Icon(Icons.upload_file, color: widget.primaryColor),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _selectedFile != null
                            ? _selectedFile!.path.split('/').last
                            : 'Upload Resume (PDF/DOC)',
                        style: TextStyle(
                            color: _selectedFile != null
                                ? Colors.black
                                : Colors.grey,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Tombol SUBMIT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('SUBMIT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    Color primaryColor, {
    required String label,
    required TextEditingController controller, // Tambahkan Controller
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller, // Pasang Controller
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEEEEEE)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
