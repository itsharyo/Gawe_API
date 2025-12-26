import 'package:flutter/material.dart';

class ElevationPage extends StatelessWidget {
  const ElevationPage({super.key});

  // Definisi Warna yang Konsisten
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
            // Judul AppBar adalah "Not found"
            title: const Text(
              'Not found',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
            actions: const [], // Tidak ada ikon aksi
          ),
        ),
      ),

      // --- Body Halaman (Pesan Error Sederhana) ---
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 8), // Sedikit jarak dari AppBar
            // Teks "Sorry"
            Text(
              'Sorry',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 4),
            // Teks "Requested content not found."
            Text(
              'Requested content not found.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
