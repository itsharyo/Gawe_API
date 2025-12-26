import 'package:flutter/material.dart';
// 1. Import file drawer baru Anda
// Jalur yang benar berdasarkan struktur folder Anda
// import '../widgets/custom_drawer.dart'; // <-- SALAH
import '../../../widgets/custom_drawer.dart'; // <-- BENAR (../ naik ke 'screens', ../ lagi naik ke 'resume', lalu ke 'widgets')

// Hapus import form, kita akan gunakan Rute Bernama (Named Routes)
// import 'upload_resume_form_screen.dart';
// import 'create_resume_form_screen.dart';

// 2. Enum _MenuOptions dihapus, karena logikanya sudah ada di CustomDrawerBody
// enum _MenuOptions { ... }

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // --- AMBIL SEMUA WARNA DARI TEMA ---
    final theme = Theme.of(context);
    final Color colorPrimaryButton = theme.primaryColor;
    final Color colorPurpleText = theme.primaryColor;
    final Color colorGreyText =
        theme.textTheme.bodyMedium?.color ?? Colors.grey[600]!; // Teks sekunder
    final Color colorTitleText =
        theme.textTheme.bodyLarge?.color ?? Colors.black87; // Teks primer
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
          // --- 2. PERUBAHAN UTAMA DI SINI ---
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.more_vert), // Ikon tiga titik
              onPressed: () {
                // Perintah untuk membuka drawer dari KIRI
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          // --- AKHIR PERUBAHAN ---
        ],
      ),

      // 3. TAMBAHKAN 'drawer' DI SINI (BUKAN 'endDrawer')
      // Memanggil widget drawer kustom Anda dari KIRI
      // Menambahkan SizedBox agar lebarnya konsisten dengan ProfilePage
      drawer: SizedBox(
        width: 320, // Lebar yang sama seperti di ProfilePage Anda
        child: Drawer(
          child: CustomDrawerBody(),
        ),
      ),
      // endDrawer: ... (DIHAPUS DARI SINI)

      // 4. BODY UTAMA (Lengkap)
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            // --- BAGIAN 1: UPLOAD RESUME ---
            _buildUploadSection(
              context, // Berikan context
              colorPurpleText,
              colorGreyText,
              colorTitleText, // Berikan warna judul
              colorPrimaryButton,
            ),

            // Garis Pemisah
            Divider(
              height: 60, // Memberi jarak atas dan bawah
              thickness: 1,
              color: Colors.grey[300],
            ),

            // --- BAGIAN 2: CREATE RESUME ---
            _buildCreateSection(
              context, // Berikan context
              colorGreyText,
              colorTitleText, // Berikan warna judul
              colorPrimaryButton,
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN (Lengkap) ---

  // Widget untuk bagian "Upload Your Resumes"
  Widget _buildUploadSection(
    BuildContext context, // Terima context
    Color colorPurpleText,
    Color colorGreyText,
    Color colorTitleText,
    Color colorPrimaryButton,
  ) {
    return Column(
      children: [
        // Judul Utama
        Text(
          "Post Your Resumes",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorPurpleText, // Gunakan warna tema
          ),
        ),
        const SizedBox(height: 8),
        // Subteks
        Text(
          "Adding your resume allows you to reply very\nquickly to many jobs from any device",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: colorGreyText, // Gunakan warna tema
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        // Ikon
        Image.asset(
          'assets/images/upload_resume_icon.png',
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.upload_file, size: 100, color: colorGreyText);
          },
        ),
        const SizedBox(height: 16),
        // Judul Ikon
        Text(
          "Upload your resume",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorTitleText, // Gunakan warna tema
          ),
        ),
        const SizedBox(height: 8),
        // Subteks Ikon
        Text(
          "Upload your resume and you'll be able to apply to\njobs in just one click!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: colorGreyText, // Gunakan warna tema
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        // Tombol "Upload"
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // print("Upload button pressed, navigating to /resume_upload");
              // Navigasi diaktifkan
              Navigator.pushNamed(context, '/resume_upload');
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //       content: Text("Navigasi ke /resume_upload (jika ada)")),
              // );
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
                "Upload",
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
    );
  }

  // Widget untuk bagian "Crete your resume"
  Widget _buildCreateSection(
    BuildContext context, // Terima context
    Color colorGreyText,
    Color colorTitleText,
    Color colorPrimaryButton,
  ) {
    return Column(
      children: [
        // Ikon
        Image.asset(
          'assets/images/create_resume_icon.png',
          height: 100,
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.edit_document, size: 100, color: colorGreyText);
          },
        ),
        const SizedBox(height: 16),
        // Judul Ikon (Typo "Crete" diperbaiki menjadi "Create")
        Text(
          "Create your resume",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: colorTitleText, // Gunakan warna tema
          ),
        ),
        const SizedBox(height: 8),
        // Subteks Ikon (Typo "Dont't" diperbaiki)
        Text(
          "Don't have a resume? Create one in no time with\nour easy-to-use Resume-builder tool",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: colorGreyText, // Gunakan warna tema
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        // Tombol "Create"
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // print("Create button pressed, navigating to /resume_create_form");
              // Navigasi diaktifkan
              Navigator.pushNamed(context, '/resume_create_form');
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text("Navigasi ke /resume_create_form (jika ada)"),
              //   ),
              // );
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
                "Create",
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
    );
  }
}
