import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Untuk SystemChrome

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);

// ----------------------------------------------------
// 1. Navbar Options Page (Gambar 1)
// ----------------------------------------------------
class NavbarOptionsPage extends StatelessWidget {
  const NavbarOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            color: lightPurpleBackground,
            border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Navbar',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Subtitle', // Subtitle
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            centerTitle: false,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    'Right',
                    style: TextStyle(
                      fontSize: 16,
                      color: framework7Purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Teks Pengantar
            const Text(
              'Navbar is a fixed (with Fixed and Through layout types) area at the top of a screen that contains Page title and navigation elements.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Navbar has 3 main parts: Left, Title and Right. Each part may contain any HTML content.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 24),

            // Tombol "Hide Navbar On Scroll"
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HideNavbarOnScrollPage(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: lightPurpleBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: dividerColor, width: 1.0),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hide Navbar On Scroll',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 2. Hide Navbar On Scroll Page (Gambar 2)
// ----------------------------------------------------
class HideNavbarOnScrollPage extends StatefulWidget {
  const HideNavbarOnScrollPage({super.key});

  @override
  State<HideNavbarOnScrollPage> createState() => _HideNavbarOnScrollPageState();
}

class _HideNavbarOnScrollPageState extends State<HideNavbarOnScrollPage> {
  final ScrollController _scrollController = ScrollController();
  // Tinggi Appbar default
  final double _navbarHeight = kToolbarHeight + 1.0;
  // State untuk melacak apakah Navbar terlihat
  bool _isNavbarVisible = true;
  // Nilai scroll terakhir yang diperiksa
  double _lastScrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Logika untuk menyembunyikan/menampilkan Navbar
  void _scrollListener() {
    final currentScroll = _scrollController.offset;
    const scrollThreshold = 50.0;

    if (!_scrollController.hasClients) return;

    // Jika scroll ke bawah (menyembunyikan)
    if (currentScroll > _lastScrollOffset &&
        currentScroll > _navbarHeight + 10) {
      if (_isNavbarVisible &&
          currentScroll - _lastScrollOffset > scrollThreshold) {
        setState(() {
          _isNavbarVisible = false;
        });
        _lastScrollOffset = currentScroll;
      }
    }
    // Jika scroll ke atas (menampilkan)
    else if (currentScroll < _lastScrollOffset) {
      if (!_isNavbarVisible &&
          _lastScrollOffset - currentScroll > scrollThreshold) {
        setState(() {
          _isNavbarVisible = true;
        });
        _lastScrollOffset = currentScroll;
      }
    }
    // Handle saat di paling atas
    if (currentScroll <= 0) {
      if (!_isNavbarVisible) {
        setState(() {
          _isNavbarVisible = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Menggunakan Stack untuk menempatkan custom AppBar di atas body
      body: Stack(
        children: <Widget>[
          // --- Body Halaman (Daftar Panjang) ---
          ListView(
            controller: _scrollController,
            // Memberikan padding atas sebesar tinggi navbar agar konten tidak tertutup
            padding: EdgeInsets.only(top: _navbarHeight),
            children: <Widget>[
              // Teks peringatan di bagian atas konten
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Navbar will be hidden if you scroll bottom',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Daftar konten panjang (Lorem Ipsum berulang)
              ...List.generate(15, (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quos maxime incidunt id ab culpa ipsa omnis eos, vel excepturi officiis neque illum perferendis dolorum magni rerum natus dolore nulla ex.\n\nEum dolore, amet enim quaerat omnis. Modi minus voluptatum quam veritatis assumenda, eligendi minima dolore in autem delectus sequi accusantium? Cupiditate praesentium autem eius, esse ratione consequatur dolor minus error.\n\nRepellendus ipsa sint quisquam delectus dolore quidem odio, praesentium, sequi temporibus amet architecto? Commodi molestiae, in repellat fugit Laudantium, fuga quia officiis error. Provident inventore iusto quas iure, expedita optio.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey[700],
                    ),
                  ),
                );
              }),
            ],
          ),

          // --- Custom Animated AppBar (Navbar) ---
          _HiddenAppBar(isVisible: _isNavbarVisible, height: _navbarHeight),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 3. Custom Animated AppBar
// ----------------------------------------------------
class _HiddenAppBar extends StatelessWidget {
  final bool isVisible;
  final double height;

  const _HiddenAppBar({required this.isVisible, required this.height});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      top: isVisible ? 0 : -height,
      left: 0,
      right: 0,
      height: height,
      child: Container(
        decoration: const BoxDecoration(
          color: lightPurpleBackground,
          border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
        ),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Hide Navbar On Scroll',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: false,
        ),
      ),
    );
  }
}
