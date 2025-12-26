// lib/features/recent_job/screens/our_gallery_page.dart

import 'package:flutter/material.dart';

// Import Custom Drawer Anda
import '../../../widgets/custom_drawer.dart';

class OurGalleryScreen extends StatefulWidget {
  final List<Map<String, String>> images;

  const OurGalleryScreen({required this.images, super.key});

  @override
  _OurGalleryScreenState createState() => _OurGalleryScreenState();
}

class _OurGalleryScreenState extends State<OurGalleryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    if (widget.images.isNotEmpty) {
      _pageController.addListener(() {
        if (_pageController.page != null &&
            _pageController.page!.round() != _currentPage) {
          setState(() {
            _currentPage = _pageController.page!.round();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNextPage() {
    if (_currentPage < widget.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalImages = widget.images.length;

    if (widget.images.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Our Gallery')),
        body: const Center(child: Text('Tidak ada gambar di galeri.')),
      );
    }

    final currentImage = widget.images[_currentPage];
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 320,
        child: Drawer(
          child: CustomDrawerBody(),
        ),
      ),
      appBar: AppBar(
        // Style AppBar sesuai gambar galeri (putih)
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),

        // Judul AppBar: "X of Total"
        title: Text(
          '${_currentPage + 1} of $totalImages',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

        actions: [
          // Tombol titik-tiga untuk membuka drawer
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // PageView: Tampilan Gambar Utama
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalImages,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                  child: Center(
                    child: Image.asset(
                      widget.images[index]['url']!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      // ERROR BUILDER DIHAPUS agar tidak menampilkan pesan error
                      // Jika gambar gagal dimuat, akan menampilkan placeholder kosong secara default
                    ),
                  ),
                );
              },
            ),
          ),

          // Bagian Bottom Bar (Caption dan Navigasi) - Sesuai Screenshot
          Container(
            // Warna latar belakang bottom bar di screenshot adalah ungu muda (deepPurple.shade50)
            color: Colors.deepPurple.shade50,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Tombol Kiri (Panah)
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 30,
                  color: _currentPage > 0 ? primaryColor : Colors.grey.shade400,
                  onPressed: _currentPage > 0 ? _goToPreviousPage : null,
                ),

                // Caption
                Expanded(
                  child: Text(
                    currentImage['caption']!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // Tombol Kanan (Panah)
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  iconSize: 30,
                  color: _currentPage < totalImages - 1
                      ? primaryColor
                      : Colors.grey.shade400,
                  onPressed:
                      _currentPage < totalImages - 1 ? _goToNextPage : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
