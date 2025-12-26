import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
const Color inputBorderColor = Color(0xFFDCDCDC);
const Color inputFillColor = Color(0xFFF7F7F7);
const Color infoTextColor = Color(0xFF6B6B6B);

// --- 1. Login Screen Layout (Gambar 1) ---
class LoginScreenLayout extends StatefulWidget {
  final bool isModal; // Flag untuk menentukan apakah ini modal atau halaman

  const LoginScreenLayout({super.key, this.isModal = false});

  @override
  State<LoginScreenLayout> createState() => _LoginScreenLayoutState();
}

class _LoginScreenLayoutState extends State<LoginScreenLayout> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menampilkan dialog hasil input (Gambar 3)
  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: lightPurpleBackground,
          title: const Text(
            'Framework7',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username: ${_usernameController.text}'),
              const SizedBox(height: 4),
              Text('Password: ${_passwordController.text}'),
            ],
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog

                // Kembali ke halaman opsi (Gambar 2)
                if (widget.isModal) {
                  Navigator.of(context).pop();
                } else {
                  // Di halaman terpisah, kembali ke halaman opsi
                  Navigator.of(context).pop();
                }

                // Reset kolom input (opsional, untuk demo)
                _usernameController.clear();
                _passwordController.clear();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: framework7Purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget untuk Input Field (Mirip Desain F7)
  Widget _buildInputField(
    TextEditingController controller,
    String label,
    String hint, {
    bool isPassword = false,
  }) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: inputFillColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: inputBorderColor, width: 1.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: infoTextColor,
          ),
          hintStyle: const TextStyle(color: infoTextColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(bottom: 12.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Latar belakang diatur ke putih jika bukan modal (halaman penuh)
      backgroundColor: widget.isModal ? Colors.transparent : Colors.white,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Judul "Framework7"
              const Text(
                'Framework7',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 60),

              // Input Username
              _buildInputField(
                _usernameController,
                'Username',
                'Your username',
              ),

              // Input Password
              _buildInputField(
                _passwordController,
                'Password',
                'Your password',
                isPassword: true,
              ),

              const SizedBox(height: 20),

              // Tombol Sign In
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _showResultDialog,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      color: framework7Purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Teks Informasi
              const Text(
                'Some text about login information.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: infoTextColor),
              ),
              const SizedBox(height: 4),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: infoTextColor),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. Halaman Opsi Login (Gambar 2) ---
class LoginOptionsPage extends StatelessWidget {
  const LoginOptionsPage({super.key});

  // Fungsi untuk menampilkan Login Screen sebagai overlay (modal/popup)
  void _showOverlayLogin(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(
        0.5,
      ), // Warna latar belakang overlay
      barrierDismissible: true,
      barrierLabel: 'Login Overlay',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: AlertDialog(
                contentPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 40.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                content: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: const LoginScreenLayout(isModal: true),
                ),
              ),
            );
          },
    );
  }

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
            title: const Text(
              'Login Screen',
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
          children: <Widget>[
            // Teks Pengantar
            const Text(
              'Framework7 comes with ready to use Login Screen layout. It could be used inside of page or inside of popup (Embedded) or as a standalone overlay:',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 30),

            // Tombol "As Separate Page"
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreenLayout(),
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
                  border: Border.all(color: dividerColor),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'As Separate Page',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol "AS OVERLAY"
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _showOverlayLogin(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: framework7Purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'AS OVERLAY',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
