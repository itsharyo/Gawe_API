import 'package:flutter/material.dart';

class AppbarPage extends StatelessWidget {
  const AppbarPage({super.key});

  // Definisi Warna yang Konsisten dengan proyek Anda
  static const Color lightPurpleBackground = Color(0xFFF7F2FF);
  static const Color dividerColor = Color(0xFFEFEFF4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang putih untuk body
      backgroundColor: Colors.white,

      // --- AppBar (Navbar Bergaya Framework7) ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            // Latar belakang AppBar sedikit lebih terang
            color: lightPurpleBackground,
            border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Tombol kembali
              },
            ),
            // ✅ Judul AppBar adalah "Not found"
            title: const Text(
              'Not found',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
            actions: const [], // Menghapus ikon aksi yang tidak diperlukan
          ),
        ),
      ),

      // --- Body Halaman (Pesan Error Sederhana) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            // ✅ Teks "Sorry"
            const Text(
              'Sorry',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            // ✅ Teks "Requested content not found."
            const Text(
              'Requested content not found.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
