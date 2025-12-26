import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tabs Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Properti untuk tampilan statis (opsional)
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      home: const TabsPage(),
    );
  }
}

// ====================================================================
// TEMPLATE KONTEN DAN DATA (Diletakkan di luar kelas untuk akses mudah)
// ====================================================================

// Konten teks panjang untuk semua tab
const String contentForAllTabs = '''
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ullam enim quia molestiae facilis laudantium voluptates obcaecati officia cum, sit libero commodi. Ratione illo suscipit temporibus sequi iure ad laboriosam accusamus?

Saepe explicabo voluptas ducimus provident, doloremque quo totam molestias! Suscipit blanditiis eaque exercitationem praesentium reprehenderit, fuga accusamus possimus sed, sint facilis ratione quod, qui dignissimos voluptas! Aliquam rerum consequuntur deleniti.

Totam reprehenderit amet commodi ipsum nam provident doloremque possimus odio itaque, est animi culpa modi consequatur reiciendis corporis libero laudantium sed eveniet unde delectus a maiores nihil dolores? Natus, perferendis.

Atque quis totam repellendus omnis alias magnam corrupti, possimus aspernatur perspiciatis quae provident consequatur minima doloremque blanditiis nihil maxime ducimus earum autem. Magni animi blanditiis similique iusto, repellat sed quisquam!

Suscipit, facere quasi atque totam. Repudiandae facilis at optio atque, rem nam, natus ratione cum enim voluptatem suscipit veniam! Repellat, est debitis. Modi nam mollitia explicabo, unde aliquid impedit! Adipisci!

Deserunt adipisci tempora asperiores, quo, nisi ex delectus vitae consectetur iste fugiat iusto dolorem autem. Itaque, ipsa voluptas, a assumenda rem, dolorum porro accusantium, officiis veniam nostrum cum cumque impedit.

Laborum illum ipsa voluptatibus possimus nesciunt ex consequatur rem, natus ad praesentium rerum libero consectetur temporibus cupiditate atque aspernatur, eaque provident eligendi quaerat ea soluta doloremque. Iure fugit, minima facere.
''';

// Daftar teks header yang dinamis
const List<String> tabHeaders = [
  'Tab 1 content',
  'Tab 2 content',
  'Tab 3 content',
];

// Widget pembangun konten tab
Widget _buildTabContent(String content) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
    ),
  );
}

// ====================================================================
// 1. Halaman Utama: TabsPage (Menu Navigasi)
// ====================================================================

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  final Color listSeparatorColor = const Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Kembali ke halaman sebelumnya')),
            );
          },
          color: Colors.black87,
        ),
        title: const Text('Tabs', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildTabsItem(context, 'Static Tabs', const StaticTabsPage()),
                _buildTabsItem(
                  context,
                  'Animated Tabs',
                  const AnimatedTabsPage(),
                ),
                _buildTabsItem(
                  context,
                  'Swipeable Tabs',
                  const SwipeableTabsPage(),
                ),
                _buildTabsItem(
                  context,
                  'Routable Tabs',
                  const RoutableTabsPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsItem(
    BuildContext context,
    String title,
    Widget? destinationPage,
  ) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: const TextStyle(fontSize: 16)),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
            size: 20,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () {
            if (destinationPage != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destinationPage),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Navigasi ke: $title (Belum Diimplementasikan)',
                  ),
                ),
              );
            }
          },
        ),
        Divider(
          height: 1,
          thickness: 0.5,
          color: listSeparatorColor,
          indent: 16,
        ),
      ],
    );
  }
}

// ====================================================================
// 2. Halaman Target 1: StaticTabsPage (Transisi Instan, Non-Swipeable)
// ====================================================================

class StaticTabsPage extends StatefulWidget {
  const StaticTabsPage({super.key});

  @override
  State<StaticTabsPage> createState() => _StaticTabsPageState();
}

class _StaticTabsPageState extends State<StaticTabsPage>
    with SingleTickerProviderStateMixin {
  final Color framework7Purple = const Color(0xFF9147FF); // Ungu
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: Duration.zero, // Transisi Instan
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_currentTabIndex != _tabController.index) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black87,
        ),
        title: const Text(
          'Static Tabs',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          // Header Dinamis
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tabHeaders[_currentTabIndex],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Konten Tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(), // Non-Swipeable
              children: <Widget>[
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
          labelColor: framework7Purple,
          unselectedLabelColor: Colors.black54,
          indicatorColor: framework7Purple,
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}

// ====================================================================
// 3. Halaman Target 2: AnimatedTabsPage (Transisi Slide, Non-Swipeable)
// ====================================================================

class AnimatedTabsPage extends StatefulWidget {
  const AnimatedTabsPage({super.key});

  @override
  State<AnimatedTabsPage> createState() => _AnimatedTabsPageState();
}

class _AnimatedTabsPageState extends State<AnimatedTabsPage>
    with SingleTickerProviderStateMixin {
  final Color framework7Purple = const Color(0xFF4788FF); // Biru
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    ); // Animasi default (slide) aktif
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_currentTabIndex != _tabController.index) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black87,
        ),
        title: const Text(
          'Animated Tabs',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          // Header Dinamis
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tabHeaders[_currentTabIndex],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Konten Tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(), // Non-Swipeable
              children: <Widget>[
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
          labelColor: framework7Purple,
          unselectedLabelColor: Colors.black54,
          indicatorColor: framework7Purple,
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}

// ====================================================================
// 4. Halaman Target 3: SwipeableTabsPage (Transisi Slide, Swipeable)
// ====================================================================

class SwipeableTabsPage extends StatefulWidget {
  const SwipeableTabsPage({super.key});

  @override
  State<SwipeableTabsPage> createState() => _SwipeableTabsPageState();
}

class _SwipeableTabsPageState extends State<SwipeableTabsPage>
    with SingleTickerProviderStateMixin {
  final Color framework7Purple = const Color(0xFF007AFF); // Biru terang
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    ); // Animasi default (slide) aktif
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_currentTabIndex != _tabController.index) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black87,
        ),
        title: const Text(
          'Swipeable Tabs',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          // Header Dinamis
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tabHeaders[_currentTabIndex],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Konten Tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              // Physics default: Mengizinkan swipe
              children: <Widget>[
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
          labelColor: framework7Purple,
          unselectedLabelColor: Colors.black54,
          indicatorColor: framework7Purple,
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}

// ====================================================================
// 5. Halaman Target 4: RoutableTabsPage (Transisi Instan, Non-Swipeable)
// ====================================================================

class RoutableTabsPage extends StatefulWidget {
  const RoutableTabsPage({super.key});

  @override
  State<RoutableTabsPage> createState() => _RoutableTabsPageState();
}

class _RoutableTabsPageState extends State<RoutableTabsPage>
    with SingleTickerProviderStateMixin {
  final Color framework7Purple = const Color(0xFFC700FF); // Magenta/Ungu Tua
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: Duration.zero, // Transisi Instan (Tanpa Slide)
    );
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_currentTabIndex != _tabController.index) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black87,
        ),
        title: const Text(
          'Tabs Routable',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Column(
        children: <Widget>[
          // Header Dinamis
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tabHeaders[_currentTabIndex],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Konten Tab
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(), // Non-Swipeable
              children: <Widget>[
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
                _buildTabContent(contentForAllTabs),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          ),
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
          labelColor: framework7Purple,
          unselectedLabelColor: Colors.black54,
          indicatorColor: framework7Purple,
          indicatorWeight: 2.0,
          indicatorPadding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}
