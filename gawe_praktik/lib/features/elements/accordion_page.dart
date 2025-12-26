import 'package:flutter/material.dart';

// Data konten panjang yang diminta untuk item lainnya
final String accordionContent =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean elementum id neque nec commodo. Sed vel justo at turpis laoreet pellentesque quis sed lorem. Integer semper arcu nibh, non mollis arcu tempor vel. Sed pharetra tortor vitae est rhoncus, vel congue dui sollicitudin. Donec eu arcu dignissim felis viverra blandit suscipit eget ipsum.';

// Data untuk Nested List
final List<String> nestedItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

// Model Data untuk setiap item akordeon
class AccordionItemData {
  final String title;
  final Widget content;
  final bool isOpposite;

  AccordionItemData(this.title, this.content, this.isOpposite);
}

class AccordionPage extends StatefulWidget {
  const AccordionPage({super.key});

  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  // Konstanta warna
  static const Color framework7Purple = Color(0xFF9147FF);
  static const Color lightPurpleBackground = Color(0xFFF7F2FF);
  static const Color blockBorderColor = Color(0xFFE0E0E0);
  static const Color iconBackground = Color(0xFFF2F2F7);

  // MANAJEMEN STATE: Kunci untuk melacak item mana yang sedang terbuka
  String? _currentlyOpenItem;

  late final List<AccordionItemData> listViewData;
  late final List<AccordionItemData> oppositeSideData;

  @override
  void initState() {
    super.initState();

    // Konten yang diperlukan
    final Widget textContent = Text(
      accordionContent,
      style: const TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
    );
    final Widget nestedContent = _buildNestedListContent();

    // Inisialisasi List View Accordion
    listViewData = [
      AccordionItemData('Lorem Ipsum', textContent, false),
      AccordionItemData('Nested List', nestedContent, false),
      AccordionItemData('Integer semper', textContent, false),
    ];

    // Inisialisasi Opposite Side (Nested List disamakan)
    oppositeSideData = [
      AccordionItemData('Lorem Ipsum', textContent, true),
      AccordionItemData(
        'Nested List',
        nestedContent,
        true,
      ), // Menggunakan konten bersarang
      AccordionItemData('Integer semper', textContent, true),
    ];
  }

  // --- Widget Pembantu untuk Konten Daftar Bersarang (Nested List) ---
  Widget _buildNestedListContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nestedItems.map((item) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: framework7Purple,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // --- FUNGSI PEMBANTU BERSATU (_buildAccordionItem) ---
  Widget _buildAccordionItem(BuildContext context, AccordionItemData item) {
    // Cek apakah item ini yang sedang terbuka
    final bool isExpanded = item.title == _currentlyOpenItem;

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        // MANAJEMEN STATE: Mengontrol apakah item terbuka atau tertutup
        initiallyExpanded: isExpanded,

        // MANAJEMEN STATE: Ketika item diperluas/ditutup, atur state-nya
        onExpansionChanged: (bool expanding) {
          setState(() {
            if (expanding) {
              _currentlyOpenItem = item.title;
            } else if (isExpanded) {
              _currentlyOpenItem = null;
            }
          });
        },

        // Panah kiri untuk Opposite Side
        leading: item.isOpposite
            ? const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black54,
                size: 20,
              )
            : null,

        title: Text(
          item.title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),

        // Panah kanan untuk List View Accordion
        trailing: item.isOpposite
            ? const SizedBox()
            : const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 20,
              ),

        tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),

        children: <Widget>[
          Padding(
            // Padding disesuaikan berdasarkan posisi ikon
            padding: EdgeInsets.only(
              left: item.isOpposite ? 48.0 : 16.0,
              right: 16.0,
              bottom: 10.0,
            ),
            child: item.content,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color dividerColor = Color(0xFFEFEFF4);

    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar (Header Halaman) ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            color: lightPurpleBackground,
            border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Accordion',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Bagian 1: List View Accordion ---
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 16.0,
                bottom: 8.0,
              ),
              child: Text(
                'List View Accordion',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: framework7Purple,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: lightPurpleBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: blockBorderColor, width: 1.0),
                ),
                child: Column(
                  children: listViewData.map((item) {
                    return _buildAccordionItem(context, item);
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- Bagian 2: Opposite Side ---
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
              child: Text(
                'Opposite Side',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: framework7Purple,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: lightPurpleBackground,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: blockBorderColor, width: 1.0),
                ),
                child: Column(
                  children: oppositeSideData.map((item) {
                    return _buildAccordionItem(context, item);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
