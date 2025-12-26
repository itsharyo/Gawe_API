import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Import semua layar Anda di sini
import 'screens/onboarding_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/role_selection_screen.dart';
import 'settings/setting_page.dart';
import 'features/chat/screens/chat_list_screen.dart';
import 'features/notification/screens/notification_screen.dart';
import 'features/profile/screens/profile_page.dart';

// --- TAMBAHAN IMPORTS UNTUK FITUR RESUME ---
import 'features/resume/screens/awards_screen.dart';
import 'features/resume/screens/certifications_screen.dart';
import 'features/resume/screens/create_resume_form_screen.dart';
// import 'features/resume/screens/edit_resume_language_screen.dart'; // <== DITAMBAH KEMBALI
import 'features/resume/screens/education_screen.dart';
import 'features/resume/screens/employment_history_screen.dart';
import 'features/resume/screens/interests_screen.dart';
import 'features/resume/screens/language_screen.dart';
import 'features/resume/screens/links_screen.dart';
import 'features/resume/screens/personal_statement_screen.dart';
import 'features/resume/screens/references_screen.dart';
import 'features/resume/screens/resume_builder_screen.dart';
import 'features/resume/screens/resume_screen.dart';
import 'features/resume/screens/skills_screen.dart';
import 'features/resume/screens/upload_resume_form_screen.dart';
import 'features/resume/screens/volunteering_screen.dart';
// ---

// --- TAMBAHAN IMPORTS UNTUK FITUR FIND JOB (DIPERBAIKI) ---
import 'features/find_job/screens/find_job_screen.dart';
import 'features/find_job/screens/company_list_screen.dart'; // <== DITAMBAH
// ---

// --- TAMBAHAN IMPOR UNTUK FITUR RECENT JOB ---
import 'features/recent_job/screens/recent_job_page.dart';
// ---

import 'providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Fungsi untuk menata status bar secara adaptif
  void _setSystemOverlays(BuildContext context, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final Color navBarColor =
        isDark ? const Color(0xFF1E003A) : const Color(0xFFF7F5FC);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparan
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: navBarColor,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final Brightness currentBrightness =
            themeProvider.themeMode == ThemeMode.dark
                ? Brightness.dark
                : Brightness.light;

        _setSystemOverlays(context, currentBrightness);

        return MaterialApp(
          title: 'Gawee Job Portal',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,

          // Tema Terang (Light Theme)
          theme: _buildThemeData(
            themeProvider.primaryColor,
            themeProvider.scaffoldColorLight,
            themeProvider.cardColor,
            Brightness.light,
          ),

          // Tema Gelap (Dark Theme)
          darkTheme: _buildThemeData(
            themeProvider.primaryColor,
            themeProvider.scaffoldColorDark,
            themeProvider.cardColor,
            Brightness.dark,
          ),

          // Home Screen
          home: const OnboardingScreen(),

          // Daftarkan semua Rute
          routes: {
            '/onboarding': (context) => const OnboardingScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignUpScreen(),
            '/dashboard': (context) => const DashboardPage(),
            '/reset_password': (context) => const ResetPasswordScreen(),
            '/role_selection': (context) => const RoleSelectionScreen(),
            '/settings': (context) => const SettingPage(),
            '/chat_list': (context) => const ChatListScreen(),
            '/notifications': (context) => const NotificationScreen(),
            '/profile': (context) => const ProfilePage(),

            // --- RUTE RESUME ---
            '/resume': (context) => const ResumeScreen(),
            '/resume_builder': (context) => const ResumeBuilderScreen(),
            '/resume_awards': (context) => const AwardsScreen(),
            '/resume_certifications': (context) => const CertificationsScreen(),
            '/resume_create_form': (context) => const CreateResumeFormScreen(),
            // Catatan: '/resume_edit_language' TIDAK BOLEH didaftarkan di sini,
            // karena ia memerlukan argumen (currentLanguage), dan hanya bisa dipanggil
            // menggunakan Navigator.push() atau onGenerateRoute.
            '/resume_education': (context) => const EducationScreen(),
            '/resume_employment': (context) => const EmploymentHistoryScreen(),
            '/resume_interests': (context) => const InterestsScreen(),
            '/resume_language': (context) => const LanguageScreen(),
            '/resume_links': (context) => const LinksScreen(),
            '/resume_personal_statement': (context) =>
                const PersonalStatementScreen(),
            '/resume_references': (context) => const ReferencesScreen(),
            '/resume_skills': (context) => const SkillsScreen(),
            '/resume_upload': (context) => const UploadResumeFormScreen(),
            '/resume_volunteering': (context) => const VolunteeringScreen(),
            // ---

            // --- RUTE FIND JOB (DIPERBAIKI) ---
            '/find_job': (context) => const FindJobScreen(),
            '/company_list': (context) =>
                const CompanyListScreen(), // <== DITAMBAH
            // ---

            // --- RUTE BARU UNTUK RECENT JOB ---
            '/recent_job': (context) => RecentJobScreen(),
            // Catatan: job_detail, gallery, dan submission dipanggil via
            // Navigator.push(MaterialPageRoute(...)) atau showModalBottomSheet(...)
            // jadi mereka tidak perlu didaftarkan di sini.
            // ---
          },
        );
      },
    );
  }

  // Fungsi pembangun ThemeData
  ThemeData _buildThemeData(
    Color primaryColor,
    Color scaffoldBackgroundColor,
    Color cardColor,
    Brightness brightness,
  ) {
    final isDark = brightness == Brightness.dark;

    // Penentuan warna teks adaptif
    final Color titleColor = isDark ? Colors.white : Colors.black87;
    final Color subtitleColor = isDark ? Colors.white70 : Colors.black54;

    final ThemeData baseTheme = isDark ? ThemeData.dark() : ThemeData.light();
    final textTheme = GoogleFonts.poppinsTextTheme(baseTheme.textTheme);

    return baseTheme.copyWith(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      cardColor: cardColor,

      // Terapkan warna teks ke semua style
      textTheme: textTheme.copyWith(
        bodyMedium: textTheme.bodyMedium?.copyWith(color: subtitleColor),
        bodyLarge: textTheme.bodyLarge?.copyWith(color: titleColor),
        titleMedium: textTheme.titleMedium?.copyWith(color: subtitleColor),
        titleLarge: textTheme.titleLarge?.copyWith(color: titleColor),
        headlineSmall: textTheme.headlineSmall?.copyWith(color: titleColor),
        headlineMedium: textTheme.headlineMedium?.copyWith(color: titleColor),
        headlineLarge: textTheme.headlineLarge?.copyWith(color: titleColor),
        displaySmall: textTheme.displaySmall?.copyWith(color: titleColor),
        displayMedium: textTheme.displayMedium?.copyWith(color: titleColor),
        displayLarge: textTheme.displayLarge?.copyWith(color: titleColor),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
        background: scaffoldBackgroundColor,
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: primaryColor,
        iconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: GoogleFonts.poppins(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        scrolledUnderElevation: 0,
      ),

      // PERBAIKAN: Gunakan primaryColor langsung dari parameter
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
