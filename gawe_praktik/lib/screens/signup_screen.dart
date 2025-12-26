import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/api_service.dart'; // Import Service API
import 'reset_password_screen.dart';
import 'dashboard_screen.dart'; // Import Dashboard untuk navigasi setelah sukses

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controller untuk menangkap input user
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variabel untuk status loading
  bool _isLoading = false;

  // Konstanta Warna (Bisa juga dipindah ke file constants.dart)
  static const Color kTextTitle = Color(0xFF333333);
  static const Color kTextSubtitle = Color(0xFF757575);
  static const Color kInactiveTab = Color(0xFFBDBDBD);

  // Fungsi untuk memanggil API Register
  void _handleRegister() async {
    // Validasi input sederhana
    if (_usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Mulai loading
    });

    // Panggil fungsi register dari ApiService
    bool success = await ApiService.register(
      _usernameController.text,
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false; // Selesai loading
    });

    if (success && mounted) {
      // Jika sukses, pindah ke Dashboard dan hapus history navigasi sebelumnya
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
        (route) => false,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );
    } else if (mounted) {
      // Jika gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Registration failed. Username or Email might be taken.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihancurkan untuk mencegah memory leak
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration(BuildContext context, String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(color: kInactiveTab),
      filled: true,
      fillColor: Theme.of(context).cardColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPageBackground = theme.scaffoldBackgroundColor;
    final kPrimaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: kPageBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kTextTitle),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    // Pastikan aset gambar ada di folder assets/images/
                    Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.work, size: 60, color: kPrimaryColor),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Gawee",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Create an account",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: kTextTitle,
                ),
              ),
              const SizedBox(height: 24),

              // Input Email
              TextFormField(
                controller: _emailController, // Hubungkan controller
                decoration: _buildInputDecoration(context, "Email Address"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Input Username
              TextFormField(
                controller: _usernameController, // Hubungkan controller
                decoration: _buildInputDecoration(context, "User Name"),
              ),
              const SizedBox(height: 16),

              // Input Password
              TextFormField(
                controller: _passwordController, // Hubungkan controller
                decoration: _buildInputDecoration(context, "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 32),

              // Tombol Submit dengan Loading Indicator
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(color: kPrimaryColor))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _handleRegister, // Panggil fungsi register
                      child: Text(
                        "SUBMIT",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),

              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: kTextSubtitle,
                    ),
                    children: [
                      const TextSpan(text: "Forgot your password? "),
                      TextSpan(
                        text: "Reset here",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "Already have an account",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: kTextSubtitle,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  side: BorderSide(
                    color: kPrimaryColor,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Kembali ke Login Screen
                },
                child: Text(
                  "SIGN IN",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                  height: 20), // Tambahan padding bawah agar tidak mepet
            ],
          ),
        ),
      ),
    );
  }
}
