import 'package:flutter/material.dart';
import 'edit_resume_language_screen.dart'; 
import 'personal_statement_screen.dart'; 
import 'employment_history_screen.dart';
import 'education_screen.dart';
import 'skills_screen.dart';
import 'language_screen.dart';
import 'certifications_screen.dart';
import 'awards_screen.dart';
import 'links_screen.dart';
import 'volunteering_screen.dart';
import 'interests_screen.dart';
import 'references_screen.dart';

class ResumeBuilderScreen extends StatefulWidget {
  const ResumeBuilderScreen({super.key});

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  String _currentLanguage = "English";

  // Fungsi untuk menampilkan Bottom Sheet Edit Bahasa
  void _editLanguage() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      // Batasi tinggi sheet untuk Edit Bahasa
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.70,
      ),
      builder: (BuildContext sheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: EditResumeLanguageScreen(
            currentLanguage: _currentLanguage,
          ),
        );
      },
    );

    if (result != null && result is String) {
      setState(() {
        _currentLanguage = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final Color colorPurpleText = const Color(0xFF6A26C4);
    final Color colorGreyText = Colors.grey[600]!;
    final Color colorCardBackground = const Color(0xFFFBF9FF);
    final Color colorIconBackground = const Color(0xFFEDE7F9);

    return Scaffold(
      // 1. APP BAR
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Resume",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              print("More options pressed");
            },
          ),
        ],
      ),
      // 2. BODY UTAMA
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul Halaman
            const Text(
              "Create your resume",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // 3. KARTU PROFIL
            _buildProfileCard(
                colorCardBackground, colorPurpleText, colorGreyText),
            const SizedBox(height: 24),

            // 4. BAGIAN RESUME LANGUAGE
            _buildLanguageSection(colorPurpleText),
            const SizedBox(height: 16),

            // 5. DAFTAR BAGIAN RESUME (Tiles)
            _buildSectionTile(
              context,
              icon: Icons.description_outlined,
              title: "Personal statement",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.work_outline,
              title: "Employment history",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.school_outlined,
              title: "Education",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.star_outline,
              title: "Skills",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.g_translate_outlined,
              title: "Langauage",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.article_outlined,
              title: "Certifications",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.military_tech_outlined,
              title: "Awards",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.link_outlined,
              title: "Links",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.volunteer_activism_outlined,
              title: "Volunteering",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.interests_outlined,
              title: "Interests",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
            _buildSectionTile(
              context,
              icon: Icons.thumb_up_outlined,
              title: "References",
              colorIconBackground: colorIconBackground,
              colorPurpleText: colorPurpleText,
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  Widget _buildProfileCard(
      Color colorCardBackground, Color colorPurpleText, Color colorGreyText) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorCardBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.grey[200],
                backgroundImage: const AssetImage('assets/images/profile_pic.png'),
                onBackgroundImageError: (exception, stackTrace) {
                  print("Error loading profile image");
                },
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile_pic.png',
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person,
                          size: 45, color: Colors.grey[400]);
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: colorPurpleText,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Tushar w3itexperts",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Web Designer",
            style: TextStyle(color: colorGreyText, fontSize: 14),
          ),
          const SizedBox(height: 2),
          Text(
            "Kota, Rajasthan",
            style: TextStyle(color: colorGreyText, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            "info@example.com",
            style: TextStyle(color: colorGreyText, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Widget untuk "Resume Langauage"
  Widget _buildLanguageSection(Color colorPurpleText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Resume Langauage",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            IconButton(
              onPressed: _editLanguage, // Memanggil Bottom Sheet Bahasa
              icon: Icon(Icons.edit_outlined, color: colorPurpleText, size: 20),
            )
          ],
        ),
        Text(
          _currentLanguage,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }

  // Widget untuk setiap item di daftar (Personal statement, Skills, dll)
  Widget _buildSectionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color colorIconBackground,
    required Color colorPurpleText,
  }) {
    // Fungsi untuk menampilkan Bottom Sheet untuk Form Resume
    void showResumeFormSheet(Widget formContent, double maxHeightFactor) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * maxHeightFactor,
        ),
        builder: (BuildContext sheetContext) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20.0)),
            ),
            child: formContent,
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            print("Tapped on $title");

            if (title == "Personal statement") {
              showResumeFormSheet(const PersonalStatementScreen(), 0.90);
            } else if (title == "Employment history") {
              showResumeFormSheet(const EmploymentHistoryScreen(), 0.95);
            }
            else if (title == "Education") {
              showResumeFormSheet(const EducationScreen(), 0.95);
            }
            else if (title == "Skills") {
              showResumeFormSheet(const SkillsScreen(), 0.65); // Tinggi sheet lebih pendek
            }
            else if (title == "Langauage") {
              showResumeFormSheet(const LanguageScreen(), 0.65); // Tinggi sheet serupa dengan Skills
            }
            else if (title == "Certifications") {
              showResumeFormSheet(const CertificationsScreen(), 0.95); // Tinggi sheet penuh karena banyak input
            }
            else if (title == "Awards") {
              showResumeFormSheet(const AwardsScreen(), 0.85); // Tinggi sheet sedang
            }
            else if (title == "Links") {
              showResumeFormSheet(const LinksScreen(), 0.65); // Tinggi sheet sedang
            }
            else if (title == "Volunteering") {
              showResumeFormSheet(const VolunteeringScreen(), 0.95);
            }
            else if (title == "Interests") {
              showResumeFormSheet(const InterestsScreen(), 0.80); // Tinggi sheet sedang
            }
            else if (title == "References") {
              showResumeFormSheet(const ReferencesScreen(), 0.95); // Tinggi sheet penuh
            }
            // Tambahkan logika else-if untuk item lain di sini jika diperlukan
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorIconBackground,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, color: colorPurpleText),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
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