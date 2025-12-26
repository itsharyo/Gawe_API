import 'package:flutter/material.dart';

// Fungsi main untuk menjalankan aplikasi (Asumsi Flutter)
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timeline Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const TimelinePage(),
    );
  }
}

// =================================================================
// KELAS UTAMA: TimelinePage (Daftar Menu)
// =================================================================
class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  final Color listSeparatorColor = const Color(0xFFE0E0E0);
  final Color framework7Purple = const Color(0xFF9147FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Timeline',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container untuk menampung List Menu
          Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildTimelineItem(context, 'Vertical Timeline'),
                _buildTimelineItem(context, 'Horizontal Timeline'),
                _buildTimelineItem(
                  context,
                  'Calendar Timeline',
                ), // Item yang dituju
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, String title) {
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
            if (title == 'Vertical Timeline') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerticalTimelinePage(),
                ),
              );
            } else if (title == 'Horizontal Timeline') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HorizontalTimelinePage(),
                ),
              );
            } else if (title == 'Calendar Timeline') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarTimelinePage(),
                ),
              );
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Navigasi ke: $title')));
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

// =================================================================
// KELAS KALENDER: CalendarTimelinePage (PERBAIKAN SORT)
// =================================================================

class CalendarTimelinePage extends StatelessWidget {
  const CalendarTimelinePage({super.key});

  final Color _lineColor = const Color(0xFFE0E0E0);

  // Data Tugas (Disesuaikan dengan gambar)
  final Map<String, List<Map<String, String>>> _calendarData = const {
    '20': [
      {'time': '10:00', 'task': 'Task 1'},
      {'time': '13:00', 'task': 'Task 2'},
      {'time': '8:00', 'task': 'Task 3'},
      {'time': '2:00', 'task': 'Task 4'},
    ],
    '21': [
      {'time': '6:00', 'task': 'Task 1'},
      {'time': '1:00', 'task': 'Task 2'},
      {'time': '1:00', 'task': 'Task 3'},
      {'time': '7:00', 'task': 'Task 4'},
    ],
    '22': [
      {'time': '23:00', 'task': 'Task 1'},
      {'time': '15:00', 'task': 'Task 2'},
      {'time': '0:00', 'task': 'Task 3'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Timeline Calendar'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Tahun dan Bulan
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '2016',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'December',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12.0),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // Mapping data hari ke widget kolom
                  children: _calendarData.entries.map((entry) {
                    return _buildDayColumn(entry.key, entry.value);
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayColumn(String day, List<Map<String, String>> tasks) {
    // SOLUSI: Buat salinan List yang dapat diubah (mutable) sebelum diurutkan.
    final mutableTasks = List<Map<String, String>>.from(tasks);

    // Lakukan sorting pada List salinan
    mutableTasks.sort((a, b) => a['time']!.compareTo(b['time']!));

    return Container(
      width: 150, // Lebar untuk setiap kolom hari
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: _lineColor, width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header Tanggal (20, 21, 22)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: _lineColor, width: 1.0)),
            ),
            width: double.infinity,
            child: Text(
              day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),

          // Daftar Tugas
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mutableTasks.map((task) {
                  // Menggunakan List yang sudah diurutkan
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['time']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          task['task']!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// KELAS HORIZONTAL: HorizontalTimelinePage (Dipertahankan)
// =================================================================

class HorizontalTimelinePage extends StatelessWidget {
  const HorizontalTimelinePage({super.key});

  final Color _lineColor = const Color(0xFFE0E0E0);
  final Color _bubbleColor = const Color(0xFFF7F7F7);

  final Map<String, List<Map<String, dynamic>>> _timelineData = const {
    '21 DEC': [
      {
        'time': '12:56',
        'title': 'Title 1',
        'subtitle': 'Subtitle 1',
        'body': 'Lorem ipsum dolor sit amet, consectetur\nadipisicing elit',
      },
      {
        'time': '13:15',
        'title': 'Title 2',
        'subtitle': 'Subtitle 2',
        'body': 'Lorem ipsum dolor sit amet, consectetur\nadipisicing elit',
      },
      {'time': '14:45', 'action': 'Do something'},
      {'time': '16:11', 'action': 'Do something else'},
    ],
    '22 DEC': [
      {'plain': 'Plain text goes here'},
    ],
    '23 DEC': [
      {
        'type': 'Card',
        'header': 'Card',
        'content': 'Card Content',
        'footer': 'Card Footer',
      },
      {'type': 'Card', 'content': 'Another Card Content'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Timeline'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _timelineData.entries.map((entry) {
              return _buildDayColumn(entry.key, entry.value);
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDayColumn(String date, List<Map<String, dynamic>> items) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: _lineColor, width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            date,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12.0),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: _buildItemContent(item),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildItemContent(Map<String, dynamic> item) {
    if (item.containsKey('time')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['time'] as String,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _bubbleColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item['title'] != null)
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                if (item['subtitle'] != null)
                  Text(
                    item['subtitle'] as String,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                if (item['body'] != null)
                  Text(
                    item['body'] as String,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                if (item['action'] != null)
                  Text(
                    item['action'] as String,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
              ],
            ),
          ),
        ],
      );
    } else if (item.containsKey('plain')) {
      return Text(
        item['plain'] as String,
        style: const TextStyle(fontSize: 14),
      );
    } else if (item.containsKey('type') && item['type'] == 'Card') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item['header'] != null)
            Text(
              item['header'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

          Container(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item['content'] != null)
                  Text(
                    item['content'] as String,
                    style: const TextStyle(fontSize: 14),
                  ),
                if (item['footer'] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      item['footer'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    }
    return Container();
  }
}

// =================================================================
// KELAS KONTEN: VerticalTimelinePage (Dipertahankan)
// =================================================================

class VerticalTimelinePage extends StatelessWidget {
  const VerticalTimelinePage({super.key});

  final Color _lineColor = const Color(0xFFE0E0E0);
  final Color _dotColor = const Color(0xFFE0E0E0);
  final Color purple = const Color(0xFF9147FF);
  final double _dotRadius = 5.0;
  final Color bubbleBgColor = const Color(0xFFF7F7F7);

  // --- Data Timeline (Dipertahankan) ---
  final List<Map<String, String>> _defaultTimelineData = const [
    {'date': '21 DEC', 'content': 'Some text goes here'},
    {'date': '22 DEC', 'content': 'Another text goes here'},
    {
      'date': '23 DEC',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor fugiat ipsum hic porro enim, accusamus perferendis, quas commodi alias quaerat eius nemo deleniti. Odio quasi quos quis iure, aperiam pariatur?',
    },
    {'date': '24 DEC', 'content': 'One more text here'},
  ];

  final List<Map<String, String>> _sideBySideTimelineData = const [
    {'date': '21 DEC', 'content': 'Some text goes here'},
    {'date': '22 DEC', 'content': 'Another text goes here'},
    {'date': '23 DEC', 'content': 'Just plain text'},
    {'date': '24 DEC', 'content': 'One more text here'},
  ];

  final List<Map<String, dynamic>> _forcedSidesTimelineData = const [
    {'date': '21 DEC', 'content': 'Some text goes here', 'side': 'right'},
    {'date': '22 DEC', 'content': 'Another text goes here', 'side': 'right'},
    {'date': '23 DEC', 'content': 'Just plain text', 'side': 'left'},
    {'date': '24 DEC', 'content': 'One more text here', 'side': 'left'},
  ];

  // --- Data Rich Content (Dipertahankan) ---
  final List<Map<String, dynamic>> _richContentTimelineData = const [
    {
      'date': '21 DEC',
      'items': [
        {
          'time': '12:56',
          'title': 'Item Title',
          'subtitle': 'Item Subtitle',
          'body':
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor fugiat ipsum hic porro enim, accusamus perferendis, quas commodi alias quaerat eius nemo deleniti. Odio quasi quos quis iure, aperiam pariatur?',
        },
        {
          'time': '15:07',
          'title': 'Item Title',
          'subtitle': 'Item Subtitle',
          'body':
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor fugiat ipsum hic porro enim, accusamus perferendis, quas commodi alias quaerat eius nemo deleniti. Odio quasi quos quis iure, aperiam pariatur?',
        },
      ],
    },
    {
      'date': '22 DEC',
      'items': [
        {
          'time': '12:56',
          'title': 'Item Title',
          'subtitle': 'Item Subtitle',
          'body':
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor fugiat ipsum hic porro enim, accusamus perferendis, quas commodi alias quaerat eius nemo deleniti. Odio quasi quos quis iure, aperiam pariatur?',
        },
        {
          'time': '15:07',
          'title': 'Item Title',
          'subtitle': 'Item Subtitle',
          'body':
              'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor fugiat ipsum hic porro enim, accusamus perferendis, quas commodi alias quaerat eius nemo deleniti. Odio quasi quos quis iure, aperiam pariatur?',
        },
      ],
    },
    {
      'date': '23 DEC',
      'items': [
        {'plain': 'Plain text goes here'},
        {
          'header': 'Card Header',
          'content': 'Card Content',
          'footer': 'Card Footer',
        },
        {'content': 'Another Card Content'},
        {'item': 'Item 1'},
        {'item': 'Item 2'},
        {'item': 'Item 3'},
      ],
    },
  ];

  // --- Data Inside Content Block ---
  final List<Map<String, String>> _insideContentBlockData = const [
    {'date': '21 DEC', 'content': 'Some text goes here'},
    {'date': '22 DEC', 'content': 'Another text goes here'},
    {
      'date': '23 DEC',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor fugiat ipsum hic porro enim, accusamus perferendis, quas commodi alias quaerat eius nemo deleniti. Odio quasi quos quis iure, aperiam pariatur?',
    },
    {'date': '24 DEC', 'content': 'One more text here'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical Timeline'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSectionTitle('Default'),
            _buildTimelineList(items: _defaultTimelineData, type: 'default'),

            const SizedBox(height: 30),

            _buildSectionTitle('Side By Side'),
            _buildTimelineList(
              items: _sideBySideTimelineData,
              type: 'side_by_side',
            ),

            const SizedBox(height: 30),

            _buildSectionTitle('Only Tablet Side By Side'),
            _buildTimelineList(items: _sideBySideTimelineData, type: 'default'),

            const SizedBox(height: 30),

            _buildSectionTitle('Forced Sides'),
            _buildTimelineList(
              items: _forcedSidesTimelineData,
              type: 'forced_sides',
            ),

            const SizedBox(height: 30),

            // --- Rich Content Timeline ---
            _buildSectionTitle('Rich Content'),
            _buildRichContentTimeline(),

            const SizedBox(height: 30),

            // --- Inside Content Block ---
            _buildInsideContentBlock(),
          ],
        ),
      ),
    );
  }

  // Widget untuk judul bagian
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // Widget untuk membuat daftar item timeline
  Widget _buildTimelineList({
    required List<Map<String, dynamic>> items,
    required String type,
  }) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        if (type == 'default') {
          return _buildDefaultItem(items[index], index == items.length - 1);
        } else if (type == 'side_by_side') {
          return _buildSideBySideItem(
            items[index] as Map<String, String>,
            index,
          );
        } else if (type == 'forced_sides') {
          return _buildForcedSidesItem(items[index], index);
        }
        return Container();
      },
    );
  }

  // --- Widget Rich Content Timeline ---
  Widget _buildRichContentTimeline() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _richContentTimelineData.length,
      itemBuilder: (context, index) {
        final dateEntry = _richContentTimelineData[index];
        final isLastDate = index == _richContentTimelineData.length - 1;
        final List items = dateEntry['items'] as List;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Kolom Kiri (Tanggal, Dot, Garis)
              SizedBox(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // Tanggal
                    Text(
                      dateEntry['date'] as String,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Indikator Titik
                    Container(
                      width: _dotRadius * 2,
                      height: _dotRadius * 2,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _dotColor,
                      ),
                    ),
                    // Garis Vertikal (menghubungkan ke tanggal berikutnya)
                    if (!isLastDate)
                      Expanded(child: Container(width: 2.0, color: _lineColor)),
                  ],
                ),
              ),

              // Kolom Tengah: Garis Tipis Vertikal (Garis konten)
              Container(
                width: 1.0, // Garis sangat tipis
                color: _lineColor,
                margin: const EdgeInsets.only(right: 12.0),
              ),

              // Kolom Kanan: Daftar Konten
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: items.map<Widget>((item) {
                    Widget contentWidget;
                    final itemMap = item as Map<String, dynamic>;

                    if (itemMap.containsKey('time')) {
                      // Rich Content Item (dengan Jam dan Bubble)
                      contentWidget = _buildRichContentItem(itemMap);
                    } else if (itemMap.containsKey('header') ||
                        itemMap.containsKey('content')) {
                      // Card Content Item (Teks polos, Card Header/Content/Footer)
                      contentWidget = _buildCardContentItem(itemMap);
                    } else if (itemMap.containsKey('item')) {
                      // List Item
                      contentWidget = _buildListItem(itemMap['item'] as String);
                    } else if (itemMap.containsKey('plain')) {
                      // Plain Text Item
                      contentWidget = Text(itemMap['plain'] as String);
                    } else {
                      contentWidget = Container();
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: contentWidget,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget untuk satu item konten Rich Content (Disesuaikan untuk Tampilan Gambar)
  Widget _buildRichContentItem(Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Jam (Teks Jam di luar bubble)
        if (item['time'] != null)
          Text(
            item['time'] as String,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        const SizedBox(height: 4),

        // Konten Bubble
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _lineColor.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item['title'] != null)
                Text(
                  item['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              if (item['subtitle'] != null)
                Text(
                  item['subtitle'] as String,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              if (item['body'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    item['body'] as String,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget untuk item konten Card Header/Content/Footer (Disesuaikan agar rapi)
  Widget _buildCardContentItem(Map<String, dynamic> item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item['header'] != null)
          Text(
            item['header'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        const SizedBox(height: 4),

        if (item['content'] != null)
          Text(item['content'] as String, style: const TextStyle(fontSize: 14)),

        const SizedBox(height: 4),

        if (item['footer'] != null)
          Text(
            item['footer'] as String,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
      ],
    );
  }

  // Widget untuk item list (Item 1, Item 2, ...)
  Widget _buildListItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
        ],
      ),
    );
  }

  // --- Fungsi-fungsi Pembantu Lainnya Dipertahankan ---

  Widget _buildDefaultItem(Map<String, dynamic> item, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                item['date']! as String,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
        _buildTimelineConnector(isLast: isLast, type: 'default'),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: _buildContentBubble(item['content']! as String),
          ),
        ),
      ],
    );
  }

  Widget _buildSideBySideItem(Map<String, String> item, int index) {
    bool isRightSide = index % 2 == 0;
    bool isLast = index == _sideBySideTimelineData.length - 1;

    Widget contentBubble = Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: _buildContentBubble(item['content']!),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: !isRightSide
              ? Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: contentBubble,
                  ),
                )
              : Container(),
        ),
        Column(
          children: <Widget>[
            _buildTimelineConnector(isLast: isLast, type: 'side_by_side'),
            Text(
              item['date']!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            if (!isLast) Container(height: 25.0, width: 2.0, color: _lineColor),
            if (isLast) const SizedBox(height: 25),
          ],
        ),
        Expanded(
          child: isRightSide
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: contentBubble,
                )
              : Container(),
        ),
      ],
    );
  }

  Widget _buildForcedSidesItem(Map<String, dynamic> item, int index) {
    bool isRightForced = item['side'] == 'right';
    bool isLast = index == _forcedSidesTimelineData.length - 1;

    Widget contentBubble = Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: _buildContentBubble(item['content']! as String),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: !isRightForced
              ? Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: contentBubble,
                  ),
                )
              : Container(),
        ),
        Column(
          children: <Widget>[
            _buildTimelineConnector(isLast: isLast, type: 'forced_sides_top'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                item['date']! as String,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            _buildTimelineConnector(
              isLast: isLast,
              type: 'forced_sides_bottom',
            ),
          ],
        ),
        Expanded(
          child: isRightForced
              ? Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: contentBubble,
                )
              : Container(),
        ),
      ],
    );
  }

  Widget _buildTimelineConnector({required bool isLast, required String type}) {
    if (type == 'forced_sides_top') {
      return Column(
        children: [
          Container(height: 20.0, width: 2.0, color: _lineColor),
          Container(
            width: _dotRadius * 2,
            height: _dotRadius * 2,
            decoration: BoxDecoration(shape: BoxShape.circle, color: _dotColor),
          ),
        ],
      );
    }

    if (type == 'forced_sides_bottom') {
      return Column(
        children: [
          if (!isLast) Container(height: 20.0, width: 2.0, color: _lineColor),
          if (isLast) const SizedBox(height: 20.0),
        ],
      );
    }

    return Column(
      children: <Widget>[
        Container(
          width: _dotRadius * 2,
          height: _dotRadius * 2,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _dotColor),
        ),
        if (!isLast && type == 'default')
          Container(height: 50.0, width: 2.0, color: _lineColor),
        if (!isLast && type == 'side_by_side')
          Container(height: 25.0, width: 2.0, color: _lineColor),
        if (isLast && type == 'default') const SizedBox(height: 50.0),
      ],
    );
  }

  Widget _buildContentBubble(String content) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _lineColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(content, style: const TextStyle(fontSize: 14)),
    );
  }

  Widget _buildInsideContentBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Inside Content Block'),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _lineColor.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: _buildTimelineListInsideContainer(),
        ),
      ],
    );
  }

  Widget _buildTimelineListInsideContainer() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _insideContentBlockData.length,
      itemBuilder: (context, index) {
        final item = _insideContentBlockData[index];
        final isLast = index == _insideContentBlockData.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    item['date']!,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: _dotRadius * 2,
                  height: _dotRadius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _dotColor,
                  ),
                ),
                if (!isLast)
                  Container(height: 50.0, width: 2.0, color: _lineColor),
                if (isLast) const SizedBox(height: 50.0),
              ],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  item['content']!,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
