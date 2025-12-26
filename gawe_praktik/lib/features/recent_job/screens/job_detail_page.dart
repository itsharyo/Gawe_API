import 'package:flutter/material.dart';
import 'our_gallery_page.dart';
import 'submission_page.dart';

// Import Custom Drawer Anda
import '../../../widgets/custom_drawer.dart';

class JobDetailScreen extends StatefulWidget {
  // Map ini berisi data job dari Dashboard/Recent Job Screen
  // Kunci wajib: 'id', 'title', 'company', 'location', 'salary', 'icon_bg_color'
  final Map<String, dynamic>
      job; // Ubah ke dynamic agar bisa menampung ID (int/string)

  const JobDetailScreen({required this.job, super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TabController _tabController;
  bool _isNavigatingToGallery = false;
  bool _isSaved = false;

  final List<Map<String, String>> galleryImages = const [
    {
      'url': 'assets/images/image1.png',
      'caption': 'Amazing beach in Goa, India'
    },
    {'url': 'assets/images/image2.png', 'caption': 'I met this dog in Bali'},
    {
      'url': 'assets/images/image3.png',
      'caption': 'Beautiful mountains in Zhangjiajie'
    },
    {
      'url': 'assets/images/image4.png',
      'caption': 'Monkey in Chinese mountains'
    },
    {
      'url': 'assets/images/image5.png',
      'caption': 'Beautiful mountains in Zhangjiajie'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    // Set status saved jika ada datanya dari backend
    if (widget.job['is_saved'] == 'true' || widget.job['is_saved'] == true) {
      _isSaved = true;
    }
  }

  void _handleTabSelection() {
    if (_tabController.index == 1 && !_tabController.indexIsChanging) {
      if (!_isNavigatingToGallery) {
        _isNavigatingToGallery = true;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OurGalleryScreen(images: galleryImages),
          ),
        ).then((_) {
          if (mounted) {
            setState(() {
              _isNavigatingToGallery = false;
              _tabController.index = 0;
            });
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  // Helper untuk mendapatkan path logo
  String _getLogoPath(String? jobTitle) {
    if (jobTitle == null) return 'assets/images/logo 4.png';
    if (jobTitle.contains('Graphic Designer'))
      return 'assets/images/logo 1.png';
    if (jobTitle.contains('Junior')) return 'assets/images/logo 3.png';
    if (jobTitle.contains('Software')) return 'assets/images/logo 4.png';
    return 'assets/images/logo 4.png';
  }

  // Helper untuk Chip
  Widget _buildJobTypeChip(BuildContext context, String label, bool isPrimary) {
    return Chip(
      label: Text(label),
      backgroundColor:
          isPrimary ? Colors.deepPurple.shade50 : Colors.grey.shade200,
      labelStyle: TextStyle(
        color: isPrimary ? Colors.deepPurple : Colors.black87,
        fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isPrimary
            ? const BorderSide(color: Colors.deepPurple, width: 1.5)
            : BorderSide.none,
      ),
    );
  }

  void _toggleBookmark() {
    setState(() {
      _isSaved = !_isSaved;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Job Saved!' : 'Job Unsaved.'),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Gunakan warna dari Job Data jika ada, kalau tidak pakai Theme primary color
    final primaryColor = Theme.of(context).primaryColor;
    final String title = widget.job['title'] ?? 'Unknown Job';
    final String company = widget.job['company'] ??
        widget.job['company_name'] ??
        'Unknown Company';
    final String location = widget.job['location'] ?? 'Unknown Location';
    final String salary =
        widget.job['salary'] ?? widget.job['salary_range'] ?? '\$0';
    final String logoPath = _getLogoPath(title);

    return Scaffold(
      key: _scaffoldKey,
      drawer:
          SizedBox(width: 320, child: const Drawer(child: CustomDrawerBody())),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // Agar menyatu dengan background
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                logoPath,
                width: 28,
                height: 28,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 28,
                  height: 28,
                  color: primaryColor.withOpacity(0.5),
                  child:
                      const Icon(Icons.business, color: Colors.white, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                company,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Header Job
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildJobTypeChip(context, 'FULLTIME', true),
                const SizedBox(width: 8),
                _buildJobTypeChip(context, 'CONTRACT', false),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)),
                Text(location,
                    style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(salary,
                        style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    const Spacer(),
                    const Text('Salary range (monthly)',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar
          TabBar(
            controller: _tabController,
            labelColor: primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primaryColor,
            tabs: const [
              Tab(text: 'Job Description'),
              Tab(text: 'Our Gallery'),
            ],
          ),

          // Konten Tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: JobDescriptionContent(primaryColor: primaryColor),
                ),
                const SizedBox
                    .expand(), // Placeholder untuk Galeri (Navigasi auto)
              ],
            ),
          ),

          // Bottom Action Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.deepPurple, width: 1.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 30,
                      color: Colors.deepPurple,
                    ),
                    onPressed: _toggleBookmark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // --- INTEGRASI APPLY JOB ---
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return SubmissionPage(
                            primaryColor: primaryColor,
                            // Pastikan ID dikirim sebagai String
                            jobId: widget.job['id'].toString(),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('APPLY JOB',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Deskripsi (Tidak Berubah)
class JobDescriptionContent extends StatelessWidget {
  final Color primaryColor;
  const JobDescriptionContent({required this.primaryColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Job Description',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: primaryColor)),
        const SizedBox(height: 10),
        const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(fontSize: 14)),
        const SizedBox(height: 20),
        Text('Requirements',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: primaryColor)),
        const SizedBox(height: 10),
        const Text(
            'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
            style: TextStyle(fontSize: 14)),
        const SizedBox(height: 10),
        _buildRequirementItem('Sed ut perspiciatis unde omnis', primaryColor),
        _buildRequirementItem('Doloremque laudantium', primaryColor),
        _buildRequirementItem('Ipsa quae ab illo inventore', primaryColor),
        _buildRequirementItem('Architecto beatae vitae dicta', primaryColor),
        _buildRequirementItem('Sunt explicabo', primaryColor),
      ],
    );
  }

  Widget _buildRequirementItem(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
