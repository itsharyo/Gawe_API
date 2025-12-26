// lib/features/recent_job/screens/recent_job_screen.dart

import 'package:flutter/material.dart';
import 'job_detail_page.dart';

// Import Custom Drawer Anda
import '../../../widgets/custom_drawer.dart';

// Dummy Data Pekerjaan (Diperluas untuk mencakup lebih banyak item seperti di screenshot)
final List<Map<String, String>> jobData = [
  // JUNIOR SOFTWARE ENGINEER (Logo 3)
  {
    'id': '1',
    'title': 'Junior Software Engineer',
    'company': 'Cosax Studios',
    'location': 'Medan, Indonesia',
    'salary': '\$500 - \$1,000',
    'is_saved': 'false',
    'icon_bg_color': '0xFF8052F7', // Warna ungu untuk fallback
    'icon_fg_color': '0xFFFFB3E9',
  },
  // SOFTWARE ENGINEER (Logo 4)
  {
    'id': '2',
    'title': 'Software Engineer',
    'company': 'Cosax Studios',
    'location': 'Medan, Indonesia',
    'salary': '\$500 - \$1,000',
    'is_saved': 'false',
    'icon_bg_color': '0xFF673AB7', // Warna ungu tua untuk fallback
    'icon_fg_color': '0xFFE8EAF6',
  },
  // GRAPHIC DESIGNER (Logo 1)
  {
    'id': '3',
    'title': 'Graphic Designer',
    'company': 'Cosax Studios',
    'location': 'Medan, Indonesia',
    'salary': '\$500 - \$1,000',
    'is_saved': 'false',
    'icon_bg_color': '0xFF388E3C', // Warna hijau untuk fallback
    'icon_fg_color': '0xFFB2DFDB',
  },
  // SOFTWARE ENGINEER (Logo 4, diulang)
  {
    'id': '4',
    'title': 'Software Engineer',
    'company': 'Cosax Studios',
    'location': 'Medan, Indonesia',
    'salary': '\$500 - \$1,000',
    'is_saved': 'false',
    'icon_bg_color': '0xFF00ACC1', // Warna teal untuk fallback
    'icon_fg_color': '0xFFE0F7FA',
  },
  // SOFTWARE ENGINEER (Logo 4, diulang)
  {
    'id': '5',
    'title': 'Software Engineer',
    'company': 'Cosax Studios',
    'location': 'Medan, Indonesia',
    'salary': '\$500 - \$1,000',
    'is_saved': 'false',
    'icon_bg_color': '0xFF673AB7',
    'icon_fg_color': '0xFFE8EAF6',
  },
  // GRAPHIC DESIGNER (Logo 1, diulang)
  {
    'id': '6',
    'title': 'Graphic Designer',
    'company': 'Cosax Studios',
    'location': 'Medan, Indonesia',
    'salary': '\$500 - \$1,000',
    'is_saved': 'false',
    'icon_bg_color': '0xFF388E3C',
    'icon_fg_color': '0xFFB2DFDB',
  },
];

class RecentJobScreen extends StatefulWidget {
  // ⬇️ ================= PERBAIKAN 1: TAMBAHKAN VARIABLE ================= ⬇️
  // Terima nama kategori. Dibuat opsional (nullable)
  // agar halaman ini tetap bisa dibuka dari tempat lain tanpa filter.
  final String? categoryName;
  final String? companyName;

  const RecentJobScreen({
    super.key,
    this.categoryName, // Tambahkan di constructor
    this.companyName,
  });
  // ⬆️ =================================================================== ⬆️

  @override
  State<RecentJobScreen> createState() => _RecentJobScreenState();
}

class _RecentJobScreenState extends State<RecentJobScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Inisialisasi sebagai list kosong, akan diisi di initState
  List<Map<String, String>> _jobs = [];

  // ⬇️ ================= PERBAIKAN 2: TAMBAHKAN initState ================= ⬇️
  @override
  void initState() {
    super.initState();
    // Panggil fungsi filter saat halaman pertama kali dimuat
    _filterJobs();
  }

  // ⬇️ ================= PERBAIKAN 3: FUNGSI FILTER BARU ================= ⬇️
  void _filterJobs() {
    final category = widget.categoryName;

    if (category == null || category.isEmpty) {
      // Jika tidak ada kategori yang dikirim, tampilkan semua pekerjaan
      _jobs = jobData;
    } else {
      // Jika ada kategori, filter datanya
      _jobs = jobData.where((job) {
        final title = job['title']!.toLowerCase();
        final categoryLower = category.toLowerCase();

        // Logika pemfilteran berdasarkan kategori dari dashboard
        if (categoryLower == 'designer') {
          return title.contains('graphic designer');
        }
        if (categoryLower == 'programmer') {
          return title
              .contains('software engineer'); // Akan mencakup Junior juga
        }
        if (categoryLower == 'manager') {
          return title.contains('manager'); // (Saat ini kosong di data dummy)
        }

        // Fallback jika ada kategori lain
        return title.contains(categoryLower);
      }).toList();
    }
  }
  // ⬆️ =================================================================== ⬆️

  void _toggleSaveJob(String jobId) {
    setState(() {
      final jobIndex = _jobs.indexWhere((job) => job['id'] == jobId);
      if (jobIndex != -1) {
        _jobs[jobIndex]['is_saved'] =
            (_jobs[jobIndex]['is_saved'] == 'true' ? 'false' : 'true');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ⬇️ ================= PERBAIKAN 4: UBAH JUDUL APPBAR ================= ⬇️
    // Buat judul dinamis berdasarkan kategori
    final String appBarTitle = widget.categoryName != null
        ? '${widget.categoryName} Jobs' // Cth: "Designer Jobs"
        : 'Recent Job'; // Judul default jika tanpa kategori
    // ⬆️ =================================================================== ⬆️

    return Scaffold(
      key: _scaffoldKey,

      // DRAWER
      drawer: SizedBox(
        width: 320,
        child: Drawer(
          child: CustomDrawerBody(),
        ),
      ),

      // APP BAR SESUAI SCREENSHOT
      appBar: AppBar(
        title: Text(appBarTitle), // Gunakan judul dinamis
        centerTitle: true,
        elevation: 0,
        // Background AppBar sesuai tema (ungu muda)
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(backgroundColor: Colors.white),
        ),
        actions: [
          // Tombol titik-tiga untuk membuka drawer
          IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              }),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KOTAK PENCARIAN
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search job here...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),

          // DAFTAR PEKERJAAN
          Expanded(
            // ⬇️ TAMBAHAN: Logika jika hasil filter kosong
            child: _jobs.isEmpty
                ? Center(
                    child: Text(
                      'No jobs found for "${widget.categoryName}"',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _jobs.length,
                    itemBuilder: (context, index) {
                      final job = _jobs[index];
                      return JobListItem(
                        job: job,
                        isSaved: job['is_saved'] == 'true',
                        onTap: () {
                          // Navigasi ke Job Detail Page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailScreen(job: job),
                            ),
                          );
                        },
                        onSaveToggle: () => _toggleSaveJob(job['id']!),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class JobListItem extends StatelessWidget {
  final Map<String, String> job;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSaveToggle;

  const JobListItem({
    required this.job,
    required this.isSaved,
    required this.onTap,
    required this.onSaveToggle,
    super.key,
  });

  // FUNGSI KRITIS: MEMETAKAN JUDUL PEKERJAAN KE FILE LOGO YANG BENAR
  String _getLogoPath(String jobTitle) {
    if (jobTitle.contains('Graphic Designer')) {
      // Graphic Designer -> logo 1.png
      return 'assets/images/logo 1.png';
    } else if (jobTitle.contains('Junior Software Engineer')) {
      // Junior Software Engineer -> logo 3.png
      return 'assets/images/logo 3.png';
    } else if (jobTitle.contains('Software Engineer')) {
      // Software Engineer (termasuk yang non-junior) -> logo 4.png
      return 'assets/images/logo 4.png';
    } else {
      // Fallback, bisa ke logo mana saja
      return 'assets/images/logo 4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Kontainer Logo
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  _getLogoPath(job['title']!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback visual jika gambar tidak termuat
                    final Color bgColor =
                        Color(int.parse(job['icon_bg_color']!));
                    final Color fgColor =
                        Color(int.parse(job['icon_fg_color']!));
                    return Container(
                      color: bgColor,
                      child: Center(
                        child:
                            Icon(Icons.lens_outlined, size: 40, color: fgColor),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job['title']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    job['location']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job['salary']!,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Ikon bookmark
            IconButton(
              icon: Icon(
                isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: isSaved ? primaryColor : Colors.grey.shade400,
              ),
              onPressed: onSaveToggle,
            ),
          ],
        ),
      ),
    );
  }
}
