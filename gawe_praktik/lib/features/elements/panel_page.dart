import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
const Color panelBackgroundColor = Color(
  0xFFF0F0F0,
); // Warna latar belakang di belakang panel

// ----------------------------------------------------
// 1. Panel Options Page (Gambar 1 & 44ec04.png)
// ----------------------------------------------------
class PanelPage extends StatelessWidget {
  const PanelPage({super.key});

  // Widget Pembantu untuk Tombol Ungu (Sesuai F7)
  Widget _buildPurpleButton(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    // Tombol di baris 1 perlu margin kanan/kiri agar Expanded bekerja.
    // Tetapi karena Expanded sudah menangani lebar, kita hanya perlu
    // memastikan margin bawah ada.
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: framework7Purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Left Panel (Drawer)
      drawer: _buildLeftPanel(context),
      // Right Panel (EndDrawer) - Dibuat minimalis
      endDrawer: _buildRightPanel(context),
      backgroundColor: Colors.white,

      // --- AppBar ---
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
            title: const Text(
              'Panel / Side panels', // Judul sesuai gambar
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),

      // --- Body Halaman (Layout tombol persis seperti gambar) ---
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Teks Pengantar
                const Padding(
                  padding: EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    'Framework7 comes with 2 panels (on left and on right), both are optional. You can put absolutely anything inside: data lists, forms, custom content, and even other isolated app view (like in right panel now) with its own dynamic navbar.',
                    style: TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),

                // BARIS 1: LEFT PANEL & RIGHT PANEL (Sama persis dengan gambar)
                Row(
                  children: [
                    // Tombol Open left panel
                    Expanded(
                      child: _buildPurpleButton(
                        context,
                        'Open left panel',
                        () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ), // Jarak di antara dua tombol atas
                    // Tombol Open right panel
                    Expanded(
                      child: _buildPurpleButton(
                        context,
                        'Open right panel',
                        () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                  ],
                ),
                // END BARIS 1

                // BARIS 2: NESTED PANEL (Full Width, di bawah Row)
                _buildPurpleButton(context, 'Open nested panel', () {
                  // Tutup panel utama jika terbuka
                  if (Scaffold.of(context).isDrawerOpen ||
                      Scaffold.of(context).isEndDrawerOpen) {
                    Navigator.pop(context);
                  }
                  _showNestedPanel(context);
                }),

                // END BARIS 2
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- Widget Left Panel (Gambar 44d639.png) ---
  Widget _buildLeftPanel(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75, // Lebar sekitar 75%
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: <Widget>[
          // Header Panel
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 16,
              right: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.work_outline,
                  color: framework7Purple,
                  size: 30,
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gawee',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Job Portal',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context), // Close button
                  child: const Icon(
                    Icons.close,
                    color: Colors.black87,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          // Daftar Item Menu
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildPanelMenuItem(
                  context,
                  'Home',
                  Icons.home,
                  isSelected: true,
                ),
                _buildPanelMenuItem(context, 'Recent Job', Icons.history),
                _buildPanelMenuItem(context, 'Find Job', Icons.search),
                _buildPanelMenuItem(
                  context,
                  'Notifications (2)',
                  Icons.notifications,
                ),
                _buildPanelMenuItem(context, 'Profile', Icons.person),
                _buildPanelMenuItem(context, 'Message', Icons.mail),
                _buildPanelMenuItem(context, 'Elements', Icons.dashboard),
                _buildPanelMenuItem(context, 'Setting', Icons.settings),
                _buildPanelMenuItem(context, 'Logout', Icons.logout),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
            width: double.infinity,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gawee Job Portal',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  'App Version 1.3',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk item menu di Panel
  Widget _buildPanelMenuItem(
    BuildContext context,
    String title,
    IconData icon, {
    bool isSelected = false,
  }) {
    final Color selectedColor = framework7Purple;
    final Color normalColor = Colors.black54;

    return Container(
      color: isSelected
          ? framework7Purple.withOpacity(0.1)
          : Colors.transparent,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              color: isSelected ? selectedColor : normalColor,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? selectedColor : Colors.black87,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            onTap: () {
              if (title == 'Open Nested Panel') {
                Navigator.pop(context); // Tutup drawer
                _showNestedPanel(context);
              } else {
                Navigator.pop(context);
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
            indent: 16,
            color: dividerColor,
          ),
        ],
      ),
    );
  }

  // --- Widget Right Panel (Sederhana) ---
  Widget _buildRightPanel(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              right: 16,
            ),
            color: framework7Purple,
            alignment: Alignment.centerRight,
            child: const Text(
              'Right Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildPanelMenuItem(context, 'Close Right Panel', Icons.close),
        ],
      ),
    );
  }

  // --- Logika Menampilkan Nested Panel (Gambar 44d9c2.png) ---
  void _showNestedPanel(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, _, __) {
          // Latar belakang abu-abu yang menutupi konten utama
          return Container(
            color: Colors.black.withOpacity(0.4),
            child: const _NestedPanelLayout(),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Transisi meluncur dari kanan
          const begin = Offset(1.0, 0.0);
          const end = Offset(0.0, 0.0);
          const curve = Curves.easeOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }
}

// ----------------------------------------------------
// 2. Nested Panel Layout (Implementasi Gambar 44d9c2.png)
// ----------------------------------------------------
class _NestedPanelLayout extends StatelessWidget {
  const _NestedPanelLayout();

  @override
  Widget build(BuildContext context) {
    // Lebar panel dibuat sekitar 75% layar
    final double panelWidth = MediaQuery.of(context).size.width * 0.75;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: panelWidth,
        height: double.infinity,
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
            child: Container(
              decoration: const BoxDecoration(
                color: lightPurpleBackground,
                border: Border(
                  bottom: BorderSide(color: dividerColor, width: 1.0),
                ),
              ),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () =>
                      Navigator.pop(context), // Menutup Nested Panel
                ),
                title: const Text(
                  'Panel / Side panels',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                centerTitle: false,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'This is page-nested Panel.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Navigator.pop(context), // Menutup Nested Panel
                  child: const Text(
                    'Close me',
                    style: TextStyle(
                      fontSize: 16,
                      color: framework7Purple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
