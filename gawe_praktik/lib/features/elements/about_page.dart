import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi Warna Ungu Framework7
    const Color framework7Purple = Color(0xFF9147FF);
    // Garis pembatas di bawah AppBar
    const Color dividerColor = Color(0xFFEFEFF4);

    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar (Hanya Ikon Panah Kembali) ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white, // Latar belakang AppBar putih
            border: Border(
              bottom: BorderSide(
                color: dividerColor, // Garis pembatas bawah tipis
                width: 1.0,
              ),
            ),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors
                .transparent, // Transparan agar terlihat warna Container (putih)
            foregroundColor: Colors.black,
            // HANYA Ikon Panah Kembali
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(''), // Judul di AppBar DIKOSONGKAN
            centerTitle: false,
          ),
        ),
      ),

      // --- BODY (Tempat Judul 'About' berada) ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),

            // Judul 'About'
            const Text(
              'About',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),

            // 💡 PERBAIKAN: Jarak di antara 'About' dan 'Welcome to Framework7' ditingkatkan
            const SizedBox(height: 32),

            // Judul "Welcome to Framework7"
            const Text(
              'Welcome to Framework7',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: framework7Purple,
              ),
            ),
            const SizedBox(height: 16),

            // Paragraf 1
            const Text(
              'Framework7 – is a free and open source HTML mobile framework to develop hybrid mobile apps or web apps with iOS or Android (Material) native look and feel. It is also an indispensable prototyping apps tool to show working app prototype as soon as possible in case you need to. Framework7 is created by Vladimir Kharlampidi.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Paragraf 2
            const Text(
              'The main approach of the Framework7 is to give you an opportunity to create iOS and Android (Material) apps with HTML, CSS and JavaScript easily and clear. Framework7 is full of freedom. It doesn\'t limit your imagination or offer ways of any solutions somehow. Framework7 gives you freedom!',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Paragraf 3
            const Text(
              'Framework7 is not compatible with all platforms. It is focused only on iOS and Android (Material) to bring the best experience and simplicity.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // Paragraf 4
            const Text(
              'Framework7 is definitely for you if you decide to build iOS and Android hybrid app (Cordova or Capacitor) or web app that looks like and feels as great native iOS or Android (Material) apps.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
