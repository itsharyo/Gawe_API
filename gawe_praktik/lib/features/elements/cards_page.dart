import 'package:flutter/material.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  // Definisi Warna yang Konsisten
  static const Color framework7Purple = Color(0xFF9147FF);
  static const Color lightPurpleBackground = Color(0xFFF7F2FF);
  static const Color dividerColor = Color(0xFFEFEFF4);
  // Warna outline diubah menjadi hitam/abu-abu gelap (sesuai permintaan)
  static const Color cardOutlineColor = Color(0xFF333333);
  static const Color cardBodyTextColor = Colors.black87;

  // --- Data Dummy ---
  static const String dummyText =
      'Cards are a great way to contain and organize your information, especially when combined with List Views. Cards can contain unique related data, like for example photos, text or links about a particular subject. Cards are typically an entry point to more complex and detailed information.';
  static const String loremIpsum =
      'Another card. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse feugiat sem est, non tincidunt ligula volutpat sit amet. Mauris aliquet magna justo.';
  static const String cardHeader = 'Card header';
  static const String cardFooter = 'Card Footer';
  static const String simpleCardText =
      'This is a simple card with plain text, but cards can also contain their own header, footer, list view, image, or any other element.';
  static const String smallText =
      'Card with header and footer. Card headers are used to display card titles and footers for additional information or just for custom actions.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar (Navbar) ---
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
              'Cards',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Teks Pengantar
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(
                dummyText,
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            // ----------------------------------------------------
            // 1. Simple Cards (Lat. Belakang Polos Putih)
            // ----------------------------------------------------
            _buildSectionTitle('Simple Cards'),
            _buildCard(
              // Card 1
              isSimple: true,
              child: const Text(
                simpleCardText,
                style: TextStyle(fontSize: 14, color: cardBodyTextColor),
              ),
            ),
            _buildCardWithHeaderFooter(
              isSimple: true,
              header: cardHeader,
              footer: cardFooter,
              body: smallText,
            ), // Card 2
            _buildCard(
              isSimple: true,
              child: Text(
                loremIpsum,
                style: const TextStyle(fontSize: 14, color: cardBodyTextColor),
              ),
            ), // Card 3
            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 2. Outline Cards (Garis Hitam, Lat. Polos Putih)
            // ----------------------------------------------------
            _buildSectionTitle('Outline Cards'),
            _buildCard(
              isOutline: true,
              child: Text(
                simpleCardText,
                style: const TextStyle(fontSize: 14, color: cardBodyTextColor),
              ),
            ),
            _buildCardWithHeaderFooter(
              isOutline: true,
              header: cardHeader,
              footer: cardFooter,
              body: smallText,
            ),
            _buildCard(
              isOutline: true,
              child: Text(
                loremIpsum,
                style: const TextStyle(fontSize: 14, color: cardBodyTextColor),
              ),
            ),
            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 3. Outline With Dividers
            // ----------------------------------------------------
            _buildSectionTitle('Outline With Dividers'),

            // Kartu 1: Card with Header/Footer dan Dividers (isOutline)
            _buildCardWithHeaderFooter(
              isOutline: true,
              useDividers: true,
              header: cardHeader,
              footer: cardFooter,
              body: smallText,
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 4. Raised Cards (KARTU KETIGA DITAMBAHKAN DI SINI)
            // ----------------------------------------------------
            _buildSectionTitle('Raised Cards'),
            _buildCard(
              isRaised: true,
              child: Text(
                simpleCardText,
                style: const TextStyle(fontSize: 14, color: cardBodyTextColor),
              ),
            ),
            _buildCardWithHeaderFooter(
              isRaised: true,
              header: cardHeader,
              footer: cardFooter,
              body: smallText,
            ),
            // ✅ PERBAIKAN: Menambahkan kartu ketiga dengan teks loremIpsum
            _buildCard(
              isRaised: true,
              child: Text(
                loremIpsum,
                style: const TextStyle(fontSize: 14, color: cardBodyTextColor),
              ),
            ),
            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 5. Styled Cards (Media/Image Card)
            // ----------------------------------------------------
            _buildSectionTitle('Styled Cards'),
            _buildMediaCard(
              imageUrl: 'https://picsum.photos/id/1015/600/300',
              title: 'Journey To Mountains',
              date: 'January 21, 2015',
              body:
                  'Quisque eget vestibulum nulla. Quisque quis dui quis ex ultricies efficitur vitae non felis. Phasellus quis nibh hendrerit...',
              footerLeft: 'Like',
              footerRight: 'Read more',
            ),
            _buildMediaCard(
              // Kartu Kedua
              imageUrl: 'https://picsum.photos/id/1084/600/300',
              title: 'Lorem Ipsum',
              date: 'January 21, 2015',
              body:
                  'Quisque eget vestibulum nulla. Quisque quis dui quis ex ultricies efficitur vitae non felis. Phasellus quis nibh hendrerit...',
              footerLeft: 'Like',
              footerRight: 'Read more',
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 6. Cards With List View
            // ----------------------------------------------------
            _buildSectionTitle('Cards With List View'),
            _buildCardWithListView(),

            const SizedBox(height: 24),
            _buildNewReleasesCard(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helpers Utama ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: framework7Purple,
        ),
      ),
    );
  }

  // Helper Card Dasar (Simple, Outline, Raised)
  Widget _buildCard({
    required Widget child,
    bool isSimple = false,
    bool isOutline = false,
    bool isRaised = false,
    bool useDividers = false,
  }) {
    // Tentukan warna latar belakang: Putih Polos
    final Color cardBg = isRaised ? Colors.white : Colors.white;

    return Card(
      elevation: isRaised ? 3.0 : 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      color: cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: isOutline || useDividers
            ? const BorderSide(color: cardOutlineColor, width: 1.0)
            : BorderSide.none,
      ),
      child: Container(
        width: double.infinity,
        // Untuk Outline Cards, padding diterapkan langsung di sini
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  // Helper Card dengan Header dan Footer
  Widget _buildCardWithHeaderFooter({
    required String header,
    required String footer,
    required String body,
    bool isSimple = false,
    bool isOutline = false,
    bool isRaised = false,
    bool useDividers = false,
  }) {
    // Border untuk Divider Card (digunakan untuk header/footer border)
    final BorderSide border = useDividers || isOutline
        ? const BorderSide(color: cardOutlineColor, width: 1.0)
        : BorderSide.none;
    final Color cardBg = isRaised ? Colors.white : Colors.white;

    return Card(
      elevation: isRaised ? 3.0 : 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      color: cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: isOutline || useDividers
            ? const BorderSide(color: cardOutlineColor, width: 1.0)
            : BorderSide.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            // Border bottom hanya jika ada divider di dalam card
            decoration: BoxDecoration(
              border: Border(bottom: useDividers ? border : BorderSide.none),
            ),
            child: Text(
              header,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // Body (Selalu ada)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              body,
              style: const TextStyle(fontSize: 14, color: cardBodyTextColor),
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              // Border top hanya jika ada divider
              border: Border(top: useDividers ? border : BorderSide.none),
            ),
            child: Text(
              footer,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Card dengan Gambar (Styled Cards)
  Widget _buildMediaCard({
    required String imageUrl,
    required String title,
    required String date,
    required String body,
    required String footerLeft,
    required String footerRight,
  }) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar dengan overlay teks
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                child: Image.network(
                  imageUrl, // Gambar Placeholder
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Container(height: 180, color: Colors.grey[300]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black)],
                  ),
                ),
              ),
            ],
          ),
          // Metadata
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              'Posted on $date',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
          // Body Teks
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              body,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
          // Footer Aksi (Like & Read more)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  footerLeft,
                  style: TextStyle(
                    color: framework7Purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  footerRight,
                  style: TextStyle(
                    color: framework7Purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Card dengan List View
  Widget _buildCardWithListView() {
    final List<String> links = [
      'Link 1',
      'Link 2',
      'Link 3',
      'Link 4',
      'Link 5',
    ];

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: cardOutlineColor, width: 1.0),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Cards With List View',
              style: TextStyle(
                color: framework7Purple,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: links.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    dense: true,
                    title: Text(
                      links[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: () {},
                  ),
                  if (index < links.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 16.0,
                      color: dividerColor,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper Card dengan New Releases (List Media)
  Widget _buildNewReleasesCard() {
    final List<Map<String, dynamic>> releases = [
      {
        'title': 'Yellow Submarine',
        'subtitle': 'Beatles',
        'image': 'https://picsum.photos/id/10/60/60',
      },
      {
        'title': 'Don\'t Stop Me Now',
        'subtitle': 'Queen',
        'image': 'https://picsum.photos/id/11/60/60',
      },
      {
        'title': 'Billie Jean',
        'subtitle': 'Michael Jackson',
        'image': 'https://picsum.photos/id/12/60/60',
      },
    ];

    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'New Releases:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: releases.length,
            itemBuilder: (context, index) {
              final item = releases[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    item['image'],
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
                title: Text(
                  item['title'],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(item['subtitle']),
                dense: true,
                onTap: () {},
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'January 20, 2015',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '5 comments',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
