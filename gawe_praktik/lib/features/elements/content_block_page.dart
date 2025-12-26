import 'package:flutter/material.dart';

class ContentBlockPage extends StatelessWidget {
  const ContentBlockPage({super.key});

  // Warna-warna yang sudah ada
  final Color framework7Purple = const Color(0xFF9147FF);
  // Warna latar belakang seragam (light purple / lavender blush)
  final Color blockBackgroundColor = const Color(0xFFF0F0FF);

  final String dummyText =
      "Donec et nulla auctor massa pharetra adipiscing ut sit amet sem. Suspendisse molestie velit vitae mattis tincidunt. Ut sit amet quam mollis, vulputate turpis vel, sagittis felis.";
  final String longDummyText =
      "Here comes paragraph within content block. Donec et nulla auctor massa pharetra adipiscing ut sit amet sem. Suspendisse molestie velit vitae mattis tincidunt. Ut sit amet quam mollis, vulputate turpis vel, sagittis felis.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Content Block',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),

              // Teks di luar Content Block
              const Text(
                'This paragraph is outside of content block. Not cool, but useful for any custom elements with custom styling.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // --- 1. Block Title ---
              _buildBlockTitle('Block Title'),
              _buildContentBlock(longDummyText), // Block tanpa kotak
              // --- 2. Strong Block ---
              _buildBlockTitle('Strong Block'),
              _buildStrongContentBlock(
                "Here comes another text block with additional “block-strong” class. Praesent nec imperdiet diam. Maecenas vel lectus porttitor, consectetur magna nec, viverra sem. Aliquam sed risus dolor. Morbi tincidunt ut libero id sodales. Integer blandit varius nisi quis consectetur.",
              ),

              // --- 3. Strong Outline Block (Berwarna + Garis Hitam) ---
              _buildBlockTitle('Strong Outline Block'),
              _buildStrongOutlineContentBlock(
                "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptates itaque autem qui quaerat vero ducimus praesentium quibusdam veniam error ut alias, numquam iste ea quos maxime consequatur ullam at a.",
              ),

              // --- 4. Strong Inset Block ---
              _buildBlockTitle('Strong Inset Block'),
              _buildStrongInsetBlock(dummyText),

              // --- 5. Strong Inset Outline Block (Berwarna + Garis Hitam) ---
              _buildBlockTitle('Strong Inset Outline Block'),
              _buildStrongInsetOutlineBlock(dummyText),

              // --- 6. Tablet Inset (Kotak warna, tanpa garis) ---
              _buildBlockTitle('Tablet Inset'),
              _buildContentBlockWithBackground(dummyText),

              // --- 7. With Header & Footer (Multiple) ---
              _buildBlockTitle('With Header & Footer'),
              _buildBlockWithHeaderFooter(longDummyText),
              _buildBlockWithHeaderFooter(longDummyText),
              _buildBlockWithHeaderFooter(longDummyText),

              // --- 8. Block Title Large (Judul kembali tanpa kotak) ---
              _buildBlockTitle('Block Title Large', isLarge: true),
              // Konten yang diberi kotak
              _buildContentBlockWithBackground(dummyText),

              // --- 9. Block Title Medium (Judul kembali tanpa kotak) ---
              _buildBlockTitle('Block Title Medium', isMedium: true),
              // Konten yang diberi kotak
              _buildContentBlockWithBackground(dummyText),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  //                       WIDGET PEMBANTU
  // =========================================================

  // Widget Pembantu untuk Judul Blok (Tetap Ungu, Tanpa Kotak)
  Widget _buildBlockTitle(
    String title, {
    bool isLarge = false,
    bool isMedium = false,
  }) {
    double fontSize = isLarge ? 22 : (isMedium ? 18 : 14);
    FontWeight fontWeight = isLarge || isMedium
        ? FontWeight.bold
        : FontWeight.w600;

    return Padding(
      padding: EdgeInsets.only(
        top: 16.0,
        bottom: isLarge || isMedium ? 12 : 8.0,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: framework7Purple,
        ),
      ),
    );
  }

  // Catatan: Widget _buildTitleBlock (dengan kotak pada judul) dihapus/tidak digunakan.

  // Widget Pembantu untuk Content Block Dasar (Tanpa Background)
  Widget _buildContentBlock(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }

  // Widget untuk Tablet Inset / Content Block dengan Background (Dipakai untuk Block Title Large/Medium)
  Widget _buildContentBlockWithBackground(String content) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: blockBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }

  // Widget Pembantu untuk Strong Block (Background Seragam)
  Widget _buildStrongContentBlock(String content) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: blockBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }

  // Widget Pembantu untuk Strong Outline Block (Background Seragam + Border HITAM)
  Widget _buildStrongOutlineContentBlock(String content) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: blockBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
      child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
    );
  }

  // Widget Pembantu untuk Strong Inset Block (Background Seragam)
  Widget _buildStrongInsetBlock(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: blockBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
      ),
    );
  }

  // Widget Pembantu untuk Strong Inset Outline Block (Background Seragam + Border HITAM)
  Widget _buildStrongInsetOutlineBlock(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: blockBackgroundColor,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Text(content, style: const TextStyle(fontSize: 16, height: 1.5)),
      ),
    );
  }

  // Widget Pembantu dengan Header dan Footer (Background Seragam)
  Widget _buildBlockWithHeaderFooter(String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Block Header',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: blockBackgroundColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Block Footer',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
