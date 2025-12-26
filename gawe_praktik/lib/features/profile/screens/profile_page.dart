import 'dart:io'; // 1. Import File
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart'; // 2. Import Image Picker

// Import Service & Widget Anda
import '../../../services/api_service.dart';
import '../../../../widgets/custom_drawer.dart';
import 'package:gawe/features/resume/screens/upload_resume_form_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Inisialisasi Image Picker
  final ImagePicker _picker = ImagePicker();

  // VARIABLE DATA PROFIL
  Map<String, dynamic>? _userProfile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  // FUNGSI AMBIL DATA DARI SERVER
  void _fetchProfile() async {
    final data = await ApiService.getProfile();
    if (!mounted) return;
    setState(() {
      _userProfile = data;
      _isLoading = false;
    });
  }

  // === 1. FITUR BARU: UPLOAD FOTO PROFIL ===
  Future<void> _pickAndUploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() => _isLoading = true);

        // Panggil API Update Avatar
        bool success = await ApiService.updateAvatar(File(image.path));

        if (!mounted) return;

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto profil berhasil diperbarui!')),
          );
          _fetchProfile(); // Refresh agar foto baru muncul
        } else {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal upload foto.')),
          );
        }
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  // === 2. FITUR BARU: HAPUS RESUME ===
  void _deleteResume() async {
    // Dialog Konfirmasi
    bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Hapus Resume"),
            content:
                const Text("Apakah Anda yakin ingin menghapus resume ini?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Hapus", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;

    if (confirm) {
      setState(() => _isLoading = true);

      // Panggil API Delete Resume
      bool success = await ApiService.deleteResume();

      if (!mounted) return;

      if (success) {
        _fetchProfile(); // Refresh data
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resume berhasil dihapus')),
        );
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menghapus resume')),
        );
      }
    }
  }

  // FUNGSI BUKA URL RESUME
  void _launchResumeUrl(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch resume file')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Navigasi ke halaman Upload/Edit
  void _navigateToUpload() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UploadResumeFormScreen()),
    );

    if (!mounted) return;

    if (result == true) {
      setState(() {
        _isLoading = true;
      });
      _fetchProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color primaryColor = theme.primaryColor;
    final Color backgroundColor = theme.scaffoldBackgroundColor;
    final Color textColor = theme.textTheme.bodyMedium?.color ?? Colors.black87;
    final Color subTextColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey;

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    // URL Resume dari Backend
    final resumeUrl = _userProfile?['resume_path'] != null
        ? "http://192.168.1.14:8000/storage/${_userProfile!['resume_path']}"
        : null;

    // URL Avatar dari Backend (Logic Baru)
    final avatarUrl = _userProfile?['avatar'] != null
        ? "http://192.168.1.14:8000/storage/${_userProfile!['avatar']}"
        : null;

    if (_isLoading) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
              bottom: BorderSide(
                  color: theme.brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : const Color(0xFFDDDDDD),
                  width: 1.3),
            ),
          ),
          padding: EdgeInsets.only(
            top: screenHeight * 0.02,
            bottom: screenHeight * 0.005,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol Kembali
                  Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: textColor,
                        size: 28,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // Tombol Menu Drawer
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: textColor,
                      size: 28,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ScrollbarTheme(
        data: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(theme.cardColor),
          trackColor: WidgetStateProperty.all(Colors.grey[400]),
          thickness: WidgetStateProperty.all(8),
          thumbVisibility: WidgetStateProperty.all(true),
          trackVisibility: WidgetStateProperty.all(true),
          radius: const Radius.circular(10),
        ),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // === GAMBAR PROFIL (DIPERBAIKI: STACK + KLIK KAMERA) ===
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100), // Bulat
                      child: Container(
                        width: screenWidth * 0.43,
                        height: screenWidth * 0.43,
                        color: Colors.grey[200],
                        child: avatarUrl != null
                            ? Image.network(
                                avatarUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, st) => const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey),
                              )
                            : Image.asset(
                                'assets/images/foto.webp',
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, st) => const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey),
                              ),
                      ),
                    ),
                    // Tombol Kamera Kecil
                    Positioned(
                      bottom: 0,
                      right: 10,
                      child: InkWell(
                        onTap: _pickAndUploadImage, // Aksi Ganti Foto
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.018),

                // Nama User
                Text(
                  _userProfile?['name'] ?? 'Guest User',
                  style: GoogleFonts.poppins(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 3),

                // Job Title
                Text(
                  _userProfile?['job_title'] ?? 'Job Title',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    color: subTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 5),

                // Location
                if (_userProfile?['location'] != null)
                  Text(
                    _userProfile!['location'],
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: subTextColor,
                    ),
                  ),

                SizedBox(height: screenHeight * 0.018),

                // Bio
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    _userProfile?['bio'] ??
                        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: textColor.withOpacity(0.9),
                      height: 1.35,
                      letterSpacing: 0.2,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // === TOMBOL MY RESUME (DIPERBAIKI: ADA DELETE) ===
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Bagian Teks & Klik Nama Resume
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (resumeUrl != null) {
                              _launchResumeUrl(resumeUrl);
                            } else {
                              _navigateToUpload();
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Resume',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                _userProfile?['resume_path'] != null
                                    ? _userProfile!['resume_path']
                                        .toString()
                                        .split('/')
                                        .last
                                    : 'No resume uploaded',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Bagian Icon Aksi (Download/Delete/Upload)
                      Row(
                        children: [
                          if (_userProfile?['resume_path'] != null) ...[
                            // Icon Download
                            IconButton(
                              icon: const Icon(
                                Icons.file_download_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () => _launchResumeUrl(resumeUrl!),
                            ),
                            // Icon Delete (Fitur Baru)
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: _deleteResume,
                            ),
                          ] else ...[
                            // Icon Upload
                            IconButton(
                              icon: const Icon(
                                Icons.upload_file,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: _navigateToUpload,
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.045),

                // === SKILLS SECTION ===
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Skills',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    // Tombol Edit Profile
                    IconButton(
                      icon: Icon(Icons.edit, color: primaryColor),
                      onPressed: _navigateToUpload,
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                // Static Skills (Bisa diganti dinamis nanti)
                _buildSkill('Problem Solving', 0.7, primaryColor, textColor,
                    subTextColor),
                SizedBox(height: screenHeight * 0.03),
                _buildSkill('Communication', 0.85, primaryColor, textColor,
                    subTextColor),

                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget Helper Skill
  Widget _buildSkill(String skill, double progress, Color color,
      Color textColor, Color subTextColor) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              skill,
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: GoogleFonts.poppins(fontSize: 16, color: subTextColor),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: subTextColor.withOpacity(0.2),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
