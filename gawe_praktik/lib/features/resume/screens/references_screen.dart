import 'package:flutter/material.dart';

class ReferencesScreen extends StatelessWidget {
  const ReferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final Color colorPrimaryButton = const Color(0xFF8D3CFF);
    final Color colorPurpleText = const Color(0xFF6A26C4);
    final Color colorIconBackground = const Color(0xFFEDE7F9);
    final Color colorUnguMuda = const Color(0xFFF7F4FD);

    // Kita return Container sebagai konten Bottom Sheet
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle (garis abu-abu di atas)
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. HEADER (IKON DAN JUDUL)
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: colorIconBackground,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Icon(Icons.thumb_up_outlined, // Ikon jempol
                          color: colorPurpleText, size: 40),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "References",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 3. FORM INPUTS
              // Name
              _buildFormLabel("Name"),
              _buildTextField("Name"),
              const SizedBox(height: 16),

              // Title / Job position
              _buildFormLabel("Resume Title / Job position"),
              _buildTextField("Resume Title / Job position"),
              const SizedBox(height: 16),

              // Company
              _buildFormLabel("Company"),
              _buildTextField("Company"),
              const SizedBox(height: 16),

              // Phone Number (optional)
              _buildFormLabel("Phone Number (optional)"),
              _buildTextField("Phone Number (optional)"),
              const SizedBox(height: 16),

              // Email
              _buildFormLabel("Email"),
              _buildTextField("Email"),
              const SizedBox(height: 32),

              // 4. TOMBOL-TOMBOL
              _buildUploadButton(colorPrimaryButton, colorUnguMuda), // Menggunakan Upload
              const SizedBox(height: 12),
              _buildCancelButton(context, colorPrimaryButton),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
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
  
  // Tombol Upload (berfungsi sama dengan Save/Outlined)
  Widget _buildUploadButton(Color colorPrimaryButton, Color colorUnguMuda) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          print("Upload References pressed");
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Upload",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: colorPrimaryButton,
          backgroundColor: colorUnguMuda,
          side: BorderSide(color: colorPrimaryButton, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, Color colorPrimaryButton) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print("Cancel pressed");
          Navigator.pop(context); // Tutup Bottom Sheet
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}