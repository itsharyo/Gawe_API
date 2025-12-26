import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/api_service.dart'; // Pastikan import ini ada
import 'dashboard_screen.dart';
import 'signup_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: const SafeArea(
          child: Column(
            children: [
              _Header(),
              _TabSelector(),
              SizedBox(height: 24),
              Expanded(
                child: TabBarView(
                  children: [
                    _JobSeekerTab(), // Tab untuk Pelamar
                    _CompanyTab(), // Tab untuk Perusahaan (SUDAH DIPERBAIKI)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================================
// WIDGET LOGIC (TERINTEGRASI)
// =======================================================================

// 1. JOB SEEKER TAB
class _JobSeekerTab extends StatefulWidget {
  const _JobSeekerTab();

  @override
  State<_JobSeekerTab> createState() => _JobSeekerTabState();
}

class _JobSeekerTabState extends State<_JobSeekerTab> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Panggil API Login sebagai Seeker
    // Tambahkan trim() juga di sini untuk keamanan ekstra
    bool success = await ApiService.login(
      _usernameController.text.trim(),
      _passwordController.text,
      'seeker',
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Failed. Check your credentials.')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kTextTitle =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign in to your registered account",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextTitle,
            ),
          ),
          const SizedBox(height: 24),
          _CustomTextField(
            hintText: "User Name",
            controller: _usernameController,
          ),
          const SizedBox(height: 16),
          _CustomTextField(
            hintText: "Password",
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 24),
          _LoginButton(
            onPressed: _handleLogin,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 16),
          const _ForgotPasswordText(),
          const SizedBox(height: 32),
          const _SocialLoginRow(),
          const SizedBox(height: 32),
          const _CreateAccountButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// 2. COMPANY TAB (VERSI PERBAIKAN DENGAN TRIM)
class _CompanyTab extends StatefulWidget {
  const _CompanyTab();

  @override
  State<_CompanyTab> createState() => _CompanyTabState();
}

class _CompanyTabState extends State<_CompanyTab> {
  final _companyIdController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    // Validasi input kosong dengan trim()
    if (_companyIdController.text.trim().isEmpty ||
        _usernameController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Panggil API Login sebagai Company
    // PERBAIKAN UTAMA: Menggunakan .trim() untuk menghapus spasi
    bool success = await ApiService.login(
      _usernameController.text.trim(),
      _passwordController.text,
      'company',
      companyId: _companyIdController.text.trim(), // Kirim Company ID bersih
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Login Failed. Check Company ID/User/Pass.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _companyIdController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final kTextTitle =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Company account",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kTextTitle,
            ),
          ),
          const SizedBox(height: 24),
          _CustomTextField(
            hintText: "Company Id (e.g., COMP-TEST-01)", // Hint diperjelas
            controller: _companyIdController,
          ),
          const SizedBox(height: 16),
          _CustomTextField(
            hintText: "User Name (e.g., pt_test)", // Hint diperjelas
            controller: _usernameController,
          ),
          const SizedBox(height: 16),
          _CustomTextField(
            hintText: "Password",
            isPassword: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 24),
          _LoginButton(
            onPressed: _handleLogin,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// =======================================================================
// WIDGET KOMPONEN
// =======================================================================

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 60,
            errorBuilder: (ctx, err, st) =>
                Icon(Icons.work, color: kPrimaryColor, size: 60),
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
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPrimaryColor = theme.primaryColor;
    final kInactiveTab = theme.brightness == Brightness.light
        ? Colors.grey.shade500
        : Colors.grey.shade400;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TabBar(
        indicatorColor: kPrimaryColor,
        indicatorWeight: 4.0,
        labelColor: kPrimaryColor,
        unselectedLabelColor: kInactiveTab,
        labelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: "JOB SEEKER"),
          Tab(text: "COMPANY"),
        ],
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const _CustomTextField({
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final kInactiveText = Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade500
        : Colors.grey.shade400;

    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.poppins(
        color: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: kInactiveText),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const _LoginButton({
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor))
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
            ),
            onPressed: onPressed,
            child: Text(
              "LOGIN",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          );
  }
}

class _ForgotPasswordText extends StatelessWidget {
  const _ForgotPasswordText();

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    final kTextSubtitle =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
            Colors.grey;

    return Center(
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
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialLoginRow extends StatelessWidget {
  const _SocialLoginRow();

  @override
  Widget build(BuildContext context) {
    final kTextSubtitle =
        Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ??
            Colors.grey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Or sign in with",
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: kTextSubtitle,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            // Aksi login Google
          },
          child: Image.asset('assets/images/google_logo.png', height: 32),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            // Aksi login Facebook
          },
          child: Image.asset('assets/images/facebook_logo.png', height: 32),
        ),
      ],
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  const _CreateAccountButton();

  @override
  Widget build(BuildContext context) {
    final kPrimaryColor = Theme.of(context).primaryColor;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(color: kPrimaryColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      child: Text(
        "CREATE ACCOUNT",
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
