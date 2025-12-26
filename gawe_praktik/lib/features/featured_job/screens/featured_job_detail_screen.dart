import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import drawer Anda
import '../../../widgets/custom_drawer.dart';
// Import halaman recent_job (untuk tombol 'Available Jobs')
import '../../recent_job/screens/recent_job_page.dart';

class FeaturedJobDetailScreen extends StatefulWidget {
  final Map<String, String> job;

  const FeaturedJobDetailScreen({super.key, required this.job});

  @override
  State<FeaturedJobDetailScreen> createState() =>
      _FeaturedJobDetailScreenState();
}

class _FeaturedJobDetailScreenState extends State<FeaturedJobDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  // Tinggi App Bar yang Diperluas
  final double _expandedAppBarHeight = 250.0;
  final double _logoHeight = 100.0;
  final BorderRadius _logoBorderRadius = BorderRadius.circular(20);

  // Logo digeser ke atas (setengah tinggi logo)
  final double _logoTranslateOffset = 50.0;
  // Jarak yang diinginkan antara dasar logo dan teks pertama
  final double logoBottomSpacing = 20.0;

  // Total kompensasi yang dibutuhkan untuk menggeser teks ke bawah dari posisi logo yang digeser ke atas.
  // Termasuk offset logo dan jarak aman di bawahnya.
  final double _totalCompensationHeight =
      (100.0 / 2) + 20.0; // 50 (untuk logo) + 20 (jarak teks) = 70.0

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _getLogoPath(String jobTitle) {
    if (jobTitle.contains('Graphic Designer')) {
      return 'assets/images/logo 1.png';
    } else if (jobTitle.contains('Junior Software Engineer')) {
      return 'assets/images/logo 3.png';
    } else if (jobTitle.contains('Software Engineer')) {
      return 'assets/images/logo 4.png';
    } else {
      return 'assets/images/logo 4.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final kPrimaryColor = theme.primaryColor;

    final double tabBarHeight = kTextTabBarHeight;
    final double toolbarHeight = kToolbarHeight;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.scaffoldBackgroundColor,
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // =====================================================
          // HEADER DENGAN GAMBAR
          // =====================================================
          SliverAppBar(
            expandedHeight: _expandedAppBarHeight,
            pinned: true,
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ],
            centerTitle: true,
            title: Text(
              widget.job['title']!,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/feature_job.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[300]),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.8),
                        end: Alignment(0.0, 0.0),
                        colors: [
                          Color(0x90000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =====================================================
          // LOGO (IKUT SCROLL)
          // =====================================================
          SliverToBoxAdapter(
            child: Center(
              // Transform.translate membuat logo tumpang tindih
              child: Transform.translate(
                offset: Offset(0.0, -_logoTranslateOffset),
                child: Container(
                  height: _logoHeight,
                  width: _logoHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: _logoBorderRadius,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: _logoBorderRadius,
                    child: Image.asset(
                      _getLogoPath(widget.job['title']!),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text('Logo', style: TextStyle(fontSize: 10)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          // =====================================================
          // INFO JOB DAN AVAILABLE JOBS
          // =====================================================
          SliverToBoxAdapter(
            child: Container(
              color: theme.scaffoldBackgroundColor,
              child: Column(
                children: [
                  // **Komponen Kunci:** SizedBox untuk mengkompensasi pergeseran logo.
                  SizedBox(height: _totalCompensationHeight),

                  Text(
                    widget.job['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.job['location']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecentJobScreen(
                              companyName: widget.job['company'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '21 Available Jobs',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                size: 16, color: kPrimaryColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          // =====================================================
          // TAB BAR
          // =====================================================
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: kPrimaryColor,
                unselectedLabelColor: Colors.grey[400],
                indicatorColor: kPrimaryColor,
                indicatorWeight: 3,
                labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                unselectedLabelStyle:
                    GoogleFonts.poppins(fontWeight: FontWeight.w500),
                tabs: const [
                  Tab(text: 'ABOUT US'),
                  Tab(text: 'RATINGS'),
                  Tab(text: 'REVIEW'),
                ],
              ),
            ),
          ),

          // =====================================================
          // ISI TAB
          // =====================================================
          SliverToBoxAdapter(
            child: SizedBox(
              // Perhitungan tinggi disederhanakan: Tinggi layar - (tinggi App Bar yang terlihat) - (tinggi Tab Bar)
              // Tinggi App Bar yang terlihat = toolbarHeight
              // Kita tambahkan kembali _logoTranslateOffset karena logo bergeser ke atas
              // dan membuat ruang scrollable di bawah berkurang.
              height: MediaQuery.of(context).size.height -
                  _expandedAppBarHeight -
                  toolbarHeight +
                  _logoTranslateOffset -
                  tabBarHeight,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _AboutUsTabContent(),
                  _RatingsTabContent(),
                  _ReviewTabContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// DELEGATE & KONTEN TAB (Tidak ada perubahan)
// =================================================================

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  const _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) => false;
}

class _AboutUsTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Text(
            'Requirements',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 10),
          const _RequirementItem(text: 'Sed ut perspiciatis unde omnis'),
          const _RequirementItem(text: 'Doloremque laudantium'),
          const _RequirementItem(text: 'Ipsa quae ab illo inventore'),
          const _RequirementItem(text: 'Architecto beatae vitae dicta'),
          const _RequirementItem(text: 'Sunt explicabo'),
        ],
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  const _RequirementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.check_circle,
              color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingsTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ratings',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '4.0',
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Icon(Icons.star_border, color: Colors.amber, size: 20),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '78,320 users',
                    style:
                        GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: const [
                    _RatingBar(value: 0.8),
                    _RatingBar(value: 0.6),
                    _RatingBar(value: 0.4),
                    _RatingBar(value: 0.2),
                    _RatingBar(value: 0.1),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingBar extends StatelessWidget {
  final double value;
  const _RatingBar({required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 8,
          backgroundColor: Colors.grey[200],
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}

class _ReviewTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: const [
        _ReviewItem(
          name: 'James Logan',
          date: '27 August 2020',
          review:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla...',
          rating: 4,
          imageUrl: 'assets/images/orang2.jpg',
        ),
        _ReviewItem(
          name: 'Leo Tucker',
          date: '15 June 2020',
          review:
              'Phasellus vel felis tellus. Mauris rutrum ligula nec dapibus feugiat.',
          rating: 4,
          imageUrl: 'assets/images/orang1.jpeg',
        ),
        _ReviewItem(
          name: 'Oscar Weston',
          date: '07 June 2020',
          review:
              'Mauris rutrum ligula nec dapibus feugiat. In vel dui laoreet...',
          rating: 4,
          imageUrl: 'assets/images/orang3.jpg',
        ),
      ],
    );
  }
}

class _ReviewItem extends StatelessWidget {
  final String name;
  final String date;
  final String review;
  final double rating;
  final String imageUrl;

  const _ReviewItem({
    required this.name,
    required this.date,
    required this.review,
    required this.rating,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(imageUrl),
            onBackgroundImageError: (_, __) {},
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  review,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 14,
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
