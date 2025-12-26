import 'package:flutter/material.dart';
// Impor ini tidak diperlukan karena kita menggunakan Rute Bernama (Named Routes)
// import 'resume_builder_screen.dart'; 

class CreateResumeFormScreen extends StatelessWidget {
  const CreateResumeFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // --- AMBIL SEMUA WARNA DARI TEMA ---
    final theme = Theme.of(context);
    // Warna-warna ini dijamin ada karena diambil dari ThemeData
    final Color colorPrimaryButton = theme.primaryColor;
    final Color colorPurpleText = theme.primaryColor;
    
    // Perbaikan: Gunakan style yang sudah diatur di main.dart
    final Color colorGreyText = theme.textTheme.bodyMedium?.color ?? Colors.black54; 
    final Color colorTitleText = theme.textTheme.bodyLarge?.color ?? Colors.black87; 
    // ---

    return Scaffold(
      // 1. APP BAR
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Resume",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              print("More options pressed");
            },
          ),
        ],
      ),
      // 2. BODY UTAMA
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Handle (garis abu-abu di atas)
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),

            // Ikon
            Image.asset(
              'assets/images/create_resume_icon.png', // Menggunakan ikon 'create'
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.edit_document, size: 80, color: colorGreyText);
              },
            ),
            const SizedBox(height: 16),

            // Judul
            Text(
              "Start Your Resume",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorPurpleText,
              ),
            ),
            const SizedBox(height: 8),

            // Subteks
            Text(
              "Masukkan detail Anda untuk memulai proses pembuatan resume.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: colorGreyText,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // 3. FORM INPUT
            // Label untuk Email
            _buildFormLabel(context, "Email", colorTitleText),
            // Input Email
            _buildTextField(context, "Type in your email"),
            const SizedBox(height: 16),

            // Label untuk Job Title
            _buildFormLabel(context, "Your job title or qualification", colorTitleText),
            // Input Job Title
            _buildTextField(context, "Your job title or qualification"),
            const SizedBox(height: 16),

            // Label untuk Lokasi
            _buildFormLabel(context, "Your location", colorTitleText),
            // Input Lokasi
            _buildTextField(
                context, "Town, county or country"), // Typo diperbaiki
            const SizedBox(height: 32),

            // 4. TOMBOL-TOMBOL
            // Tombol "Create" (Outlined)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  print(
                      "Form Create pressed, navigating to /resume_builder");
                  // Gunakan Rute Bernama yang sudah didaftarkan di main.dart
                  Navigator.pushNamed(context, '/resume_builder');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorPrimaryButton,
                  backgroundColor: theme.cardColor, // Gunakan cardColor
                  side: BorderSide(color: colorPrimaryButton, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol "Cancel" (Elevated)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Form Cancel pressed");
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimaryButton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  // Widget untuk Label Form (dengan Bintang Merah)
  Widget _buildFormLabel(
      BuildContext context, String label, Color colorTitleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              text: label,
              // Gunakan colorTitleText yang sudah kita definisikan
              style: TextStyle(
                color: colorTitleText,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              children: const [
                TextSpan(
                  text: " *",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk Input Text Field
  Widget _buildTextField(BuildContext context, String hintText) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor, // Gunakan cardColor agar bisa gelap/terang
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: TextField(
        // Style teks input disesuaikan dengan warna tema
        style: TextStyle(color: theme.textTheme.bodyLarge?.color),
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