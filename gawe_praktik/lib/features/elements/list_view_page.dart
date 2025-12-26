import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final Color framework7Purple = const Color(0xFF9147FF);
  final Color listBackground = Colors.grey.shade100;
  final Color listOutlineColor = Colors.grey.shade400;
  final Color listSeparatorColor = Colors.grey.shade300;

  // Menggunakan Ikon Bawaan Flutter
  final IconData mainIcon = Icons.shopping_bag_outlined;

  // Variabel state untuk Switch/Toggle
  bool _toggleValue1 = true;
  bool _ultraLongToggleValue = false; // Variabel state untuk Ultra Long

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List View',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Deskripsi Awal
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Framework7 allows you to be flexible with list views (table views). You can make them as navigation menus, you can use there icons, inputs, and any elements inside of the list, and even make them nested:',
                style: TextStyle(fontSize: 14),
              ),
            ),

            // --- 1. Simple List ---
            _buildSectionTitle('Simple List'),
            _buildSimpleList(strong: false, outline: false, inset: false),

            // --- 2. Strong List ---
            _buildSectionTitle('Strong List'),
            _buildSimpleList(strong: true, outline: false, inset: false),

            // --- 3. Strong Outline List ---
            _buildSectionTitle('Strong Outline List'),
            _buildSimpleList(strong: true, outline: true, inset: false),

            // --- 4. Strong Inset List ---
            _buildSectionTitle('Strong Inset List'),
            _buildSimpleList(strong: true, outline: false, inset: true),

            // --- 5. Strong Outline Inset List ---
            _buildSectionTitle('Strong Outline Inset List'),
            _buildSimpleList(strong: true, outline: true, inset: true),

            // --- 6. Simple Links List ---
            _buildSectionTitle('Simple Links List'),
            _buildSimpleLinksList(),

            // --- 7. Data list, with icons ---
            _buildSectionTitle('Data list, with icons'),
            _buildDataList(),

            // 8. Links, Header, Footer (Complex List)
            _buildSectionTitle('Links, Header, Footer'),
            _buildComplexList(),

            // 9. Links, no icons
            _buildSectionTitle('Links, no icons'),
            _buildBasicListItem('Ivan Petrov', isLink: true),
            _buildBasicListItem('John Doe', isLink: true),

            // ✅ 10. Grouped with sticky titles
            _buildSectionTitle('Grouped with sticky titles'),
            _buildGroupedList(),

            // --- 11. Media Lists (Songs) ---
            _buildSectionTitle('Media Lists'),
            // Deskripsi Media Lists
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                'Media Lists are almost the same as Data Lists, but with a more flexible layout for visualization of more complex data, like products, services, users, etc.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            // Sub-Judul Songs
            _buildGroupHeader('Songs', color: framework7Purple),
            _buildMediaList(), // <-- Item Michael Jackson ada di sini
            // ✅ 11.5. Mail App List
            _buildMailAppList(),

            // --- 12. Something More Simple (List Simple Icons) ---
            _buildSectionTitle('Something more simple'),
            _buildSimpleIconList(), // <-- Item dimodifikasi di sini

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- WIDGET PEMBANTU UTAMA ---

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: framework7Purple,
        ),
      ),
    );
  }

  // Widget untuk List Item Dasar
  Widget _buildBasicListItem(
    String title, {
    String? subtitle,
    String? trailing,
    bool isLink = false,
    Widget? leading,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: leading,
          title: Text(title, style: const TextStyle(fontSize: 16)),
          subtitle: subtitle != null
              ? Text(subtitle, style: TextStyle(color: Colors.grey.shade600))
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing != null)
                Text(
                  trailing,
                  style: TextStyle(
                    color: isLink ? framework7Purple : Colors.black87,
                  ),
                ),
              if (isLink)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
            ],
          ),
          onTap: isLink ? () {} : null,
        ),
        // Divider hanya jika tidak ada leading widget (seperti Simple List)
        if (leading == null)
          Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
      ],
    );
  }

  // Helper untuk membuat Leading Icon/Logo
  Widget _buildLeadingLogo() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: framework7Purple,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(child: Icon(mainIcon, color: Colors.white, size: 16)),
    );
  }

  // Widget khusus untuk List Item dengan Switch/Toggle di belakang
  Widget _buildListItemWithToggle(
    String title,
    bool value, {
    Widget? leading,
    required Function(bool) onChanged,
  }) {
    return Column(
      children: [
        SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          title: Text(title, style: const TextStyle(fontSize: 16)),
          value: value,
          onChanged: onChanged,
          secondary: leading,
          activeColor: framework7Purple,
        ),
        Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
      ],
    );
  }

  // --- BLOK LIST SPESIFIK ---

  // Simple List, Strong List, Strong Outline List, Inset
  Widget _buildSimpleList({
    required bool strong,
    required bool outline,
    required bool inset,
  }) {
    final BorderRadius borderRadius = BorderRadius.circular(inset ? 10 : 0);
    final EdgeInsets margin = inset
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        : EdgeInsets.zero;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: strong ? listBackground : Colors.white,
        borderRadius: borderRadius,
        border: outline
            ? Border.all(color: listOutlineColor, width: 1.0)
            : null,
      ),
      child: Column(
        children: [
          _buildBasicListItem(
            'Item 1',
            isLink: false,
            leading: strong ? null : const SizedBox(),
          ),
          Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
          _buildBasicListItem(
            'Item 2',
            isLink: false,
            leading: strong ? null : const SizedBox(),
          ),
          Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
          _buildBasicListItem(
            'Item 3',
            isLink: false,
            leading: strong ? null : const SizedBox(),
          ),
        ],
      ),
    );
  }

  // Simple Links List
  Widget _buildSimpleLinksList() {
    return Column(
      children: [
        _buildBasicListItem('Link 1', isLink: true, leading: null),
        _buildBasicListItem('Link 2', isLink: true, leading: null),
        _buildBasicListItem('Link 3', isLink: true, leading: null),
      ],
    );
  }

  // Data List (Ivan Petrov, Jenna Smith)
  Widget _buildDataList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBasicListItem(
          'Ivan Petrov',
          trailing: 'CEO',
          leading: _buildLeadingLogo(),
        ),
        _buildBasicListItem(
          'John Doe',
          trailing: '5',
          leading: _buildLeadingLogo(),
        ),
        _buildBasicListItem('Jenna Smith', leading: _buildLeadingLogo()),

        // Links section
        _buildSectionTitle('Links'),
        _buildBasicListItem(
          'Ivan Petrov',
          trailing: 'CEO',
          isLink: true,
          leading: _buildLeadingLogo(),
        ),
        _buildBasicListItem(
          'John Doe',
          trailing: 'Cleaner',
          isLink: true,
          leading: _buildLeadingLogo(),
        ),
        _buildBasicListItem(
          'Jenna Smith',
          isLink: true,
          leading: _buildLeadingLogo(),
        ),
      ],
    );
  }

  // Complex List (Links, Header, Footer)
  Widget _buildComplexList() {
    // Helper untuk membuat Widget Logo/Icon di complex list
    Widget leadingComplexImageWidget() {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: framework7Purple,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Icon(mainIcon, color: Colors.white, size: 16)),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name
        _buildDetailItem(
          'Name',
          'John Doe',
          'Edit',
          leadingComplexImageWidget(),
        ),
        // Phone
        _buildDetailItem(
          'Phone',
          '+7 90 111-22-3344',
          'Edit',
          leadingComplexImageWidget(),
        ),
        // Email 1
        _buildDetailItem(
          'Email',
          'john@doe',
          'Edit',
          leadingComplexImageWidget(),
          footer: 'Home',
        ),
        // Email 2
        _buildDetailItem(
          'Email',
          'john@framework7',
          'Edit',
          leadingComplexImageWidget(),
          footer: 'Work',
        ),
      ],
    );
  }

  // Fungsi _buildDetailItem diubah untuk menerima Widget leading
  Widget _buildDetailItem(
    String header,
    String title,
    String trailingText,
    Widget leadingWidget, {
    String? footer,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: leadingWidget, // Menggunakan Widget Logo
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                header,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Text(title, style: const TextStyle(fontSize: 16)),
              if (footer != null)
                Text(
                  footer,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                trailingText,
                style: TextStyle(color: framework7Purple, fontSize: 14),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
          onTap: () {},
        ),
        Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
      ],
    );
  }

  // ✅ Grouped List (Simulasi Kontak A, B, C)
  Widget _buildGroupedList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group Title Here
        _buildGroupHeader('Group Title Here', color: Colors.black54),
        _buildBasicListItem('Ivan Petrov', isLink: true),
        _buildBasicListItem('Jenna Smith', isLink: true),

        // Judul Sticky: Grouped with sticky titles
        _buildGroupHeader(
          'Grouped with sticky titles',
          isSticky: true,
          color: framework7Purple,
        ),

        // Grup A
        _buildGroupHeader('A', isSticky: true, color: framework7Purple),
        _buildBasicListItem('Aaron', leading: null),
        _buildBasicListItem('Abbie', leading: null),
        _buildBasicListItem('Adam', leading: null),

        // Grup B
        _buildGroupHeader('B', isSticky: true, color: framework7Purple),
        _buildBasicListItem('Bailey', leading: null),
        _buildBasicListItem('Barclay', leading: null),
        _buildBasicListItem('Bartolo', leading: null),

        // ✅ Grup C ditambahkan
        _buildGroupHeader('C', isSticky: true, color: framework7Purple),
        _buildBasicListItem('Caiden', leading: null),
        _buildBasicListItem('Calvin', leading: null),
        _buildBasicListItem('Candy', leading: null),

        // --- LIST BARU: Mixed and Nested sesuai foto (sudah dimodifikasi) ---
        _buildMixedAndNestedList(),
        // --- AKHIR LIST BARU ---
      ],
    );
  }

  Widget _buildGroupHeader(
    String title, {
    Color? color,
    bool isSticky = false,
  }) {
    return Container(
      width: double.infinity,
      color: isSticky ? listBackground : Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color ?? Colors.black54,
        ),
      ),
    );
  }

  // --- FUNGSI BARU UNTUK LIST "Mixed and Nested" ---
  Widget _buildMixedAndNestedList() {
    // Helper untuk Leading Icon/Logo seperti yang ada di foto
    Widget _buildLeadingIcon() {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: framework7Purple,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Icon(mainIcon, color: Colors.white, size: 16)),
      );
    }

    // Helper untuk Leading dengan dua ikon
    Widget _buildTwoIconsLeading() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLeadingIcon(),
          const SizedBox(width: 4),
          _buildLeadingIcon(),
        ],
      );
    }

    // List item dengan divider
    Widget _buildItem(
      String title, {
      String? trailing,
      Widget? leading,
      bool isLink = false,
    }) {
      return _buildBasicListItem(
        title,
        trailing: trailing,
        leading: leading,
        isLink: isLink,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Judul: Candy (Header yang ada di foto)
        _buildGroupHeader('Candy', color: Colors.black54),

        // --- Mixed and nested ---
        _buildSectionTitle('Mixed and nested'),
        // Ivan Petrov (Icon, Link, Trailing Text)
        _buildItem(
          'Ivan Petrov',
          leading: _buildLeadingIcon(),
          trailing: 'CEO',
          isLink: true,
        ),
        // Two icons here (Two Icons, Link)
        _buildItem(
          'Two icons here',
          leading: _buildTwoIconsLeading(),
          isLink: true,
        ),

        // --- No icons here (Group header) ---
        _buildGroupHeader('No icons here'),
        // Ivan Petrov (Link, Trailing Text, No Icon)
        _buildItem('Ivan Petrov', trailing: 'CEO', isLink: true),
        // Two icons here (Link, No Icon)
        _buildItem('Two icons here', isLink: true),

        // --- No icons here (Group header, tapi di tengah item) ---
        _buildGroupHeader('No icons here'),
        // Ultra long text goes here (No Icon) - Item ini tetap sebagai teks biasa
        _buildItem('Ultra long text goes here, no, it is really really long'),

        // With toggle (dengan Switch 1) - Item ini tetap
        _buildListItemWithToggle(
          'With toggle',
          _toggleValue1,
          leading: _buildLeadingIcon(),
          onChanged: (bool value) {
            setState(() {
              _toggleValue1 = value;
            });
          },
        ),

        // 🔄 ITEM YANG DIUBAH: Ultra long text goes here (dengan Icon, sekarang dengan Toggle)
        _buildListItemWithToggle(
          'Ultra long text goes here, no, it is really really long',
          _ultraLongToggleValue,
          leading: _buildLeadingIcon(),
          onChanged: (bool value) {
            setState(() {
              _ultraLongToggleValue = value;
            });
          },
        ),

        // Item 'With toggle' yang kedua sudah dihapus

        // --- Tablet inset ---
        _buildSectionTitle('Tablet inset'),
        // Ivan Petrov
        _buildItem(
          'Ivan Petrov',
          leading: _buildLeadingIcon(),
          trailing: 'CEO',
          isLink: true,
        ),
        // Two icons here
        _buildItem('Two icons here', leading: _buildTwoIconsLeading()),
        // Ultra long text goes here
        _buildItem(
          'Ultra long text goes here, no, it is really really long',
          leading: _buildLeadingIcon(),
        ),

        // Footer Text
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Text(
            'This list block will look like "inset" only on tablets (iPad)',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ],
    );
  }
  // --- AKHIR FUNGSI Mixed and Nested ---

  // Media List (Songs) - Sudah dimodifikasi untuk Media Lists
  Widget _buildMediaList() {
    const String songDesc =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis condimentum, ut dignissim lacus tincidunt. Cras dolor metus, ultrices condimentum...';

    return Column(
      children: [
        _buildMediaItem(
          'Yellow Submarine',
          'Beatles',
          songDesc,
          '\$15', // Menggunakan Harga
          'dummy/album1.jpg',
        ),
        _buildMediaItem(
          'Don\'t Stop Me Now',
          'Queen',
          songDesc,
          '\$22', // Menggunakan Harga
          'dummy/album2.jpg',
        ),
        _buildMediaItem(
          'Billie Jean',
          'Michael Jackson',
          songDesc,
          '\$16', // Menggunakan Harga
          'dummy/album3.jpg',
        ),
      ],
    );
  }

  // Menggunakan Icon placeholder karena tidak menggunakan assets
  Widget _buildMediaItem(
    String title,
    String subtitle,
    String description,
    String trailingText, // Harga
    String imagePath,
  ) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              // Mengganti warna background menjadi abu-abu gelap untuk simulasi foto
              color: Colors.grey.shade400,
              // Menggunakan border radius kecil
              borderRadius: BorderRadius.circular(4),
            ),
            // Menggunakan ikon gambar sebagai placeholder
            child: const Icon(Icons.image, color: Colors.white, size: 30),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subtitle adalah artis/penyanyi
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 4),
              // Description
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Harga/Trailing Text
              Text(
                trailingText,
                // Harga agak pudar (hitam 54) dan ukuran 14
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              const SizedBox(width: 8),
              // Chevron icon
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ],
          ),
          onTap: () {},
        ),
        Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
      ],
    );
  }

  // --- FUNGSI BARU UNTUK LIST "MAIL APP" ---
  Widget _buildMailAppItem({
    required String header,
    required String subject,
    required String body,
    required String time,
    bool showChevron = true,
  }) {
    // Body harus dibatasi agar tidak terlalu panjang
    final bodySafe = body.replaceAll('\n', ' ');
    final trimmedBody =
        bodySafe.substring(0, bodySafe.length > 100 ? 100 : bodySafe.length) +
            (bodySafe.length > 100 ? '...' : '');

    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),

          // Leading dihilangkan (sesuai foto)
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              header,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subject,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                trimmedBody,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment
                .start, // Penting agar sejajar dengan baris pertama
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.black54, fontSize: 14),
              ),
              if (showChevron)
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
            ],
          ),
          onTap: () {},
        ),
        Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
      ],
    );
  }

  // Fungsi untuk membuat seluruh blok "Mail App"
  Widget _buildMailAppList() {
    const String bodyText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis condimentum, ut dignissim lacus tincidunt. Cras dolor metus, ultrices condimentum...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header "Mail App"
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Mail App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        // 1. Facebook
        _buildMailAppItem(
          header: 'Facebook',
          subject: 'New messages from John Doe',
          body: bodyText,
          time: '17:14',
        ),

        // 2. John Doe (via Twitter)
        _buildMailAppItem(
          header: 'John Doe (via Twitter)',
          subject: 'John Doe (@_johndoe) mentioned you on Twitter!',
          body: bodyText,
          time: '17:11',
        ),

        // 3. Facebook
        _buildMailAppItem(
          header: 'Facebook',
          subject: 'New messages from John Doe',
          body: bodyText,
          time: '16:48',
        ),

        // 4. John Doe (via Twitter)
        _buildMailAppItem(
          header: 'John Doe (via Twitter)',
          subject: 'John Doe (@_johndoe) mentioned you on Twitter!',
          body: bodyText,
          time: '15:32',
        ),

        // --- With centered chevron icon ---
        _buildSectionTitle('With centered chevron icon'),

        // 5. Facebook
        _buildMailAppItem(
          header: 'Facebook',
          subject: 'New messages from John Doe',
          body: bodyText,
          time: '17:14',
        ),

        // 6. John Doe (via Twitter)
        _buildMailAppItem(
          header: 'John Doe (via Twitter)',
          subject: 'John Doe (@_johndoe) mentioned you on Twitter!',
          body: bodyText,
          time: '17:11',
        ),
      ],
    );
  }

  // Simple Media List (Seperti di foto 'Something more simple')
  Widget _buildSimpleMediaList() {
    // Helper untuk placeholder gambar/media
    Widget _buildSimpleMediaLeading() {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
        // Menggunakan ikon gambar sebagai placeholder
        child: const Icon(Icons.image, color: Colors.white, size: 20),
      );
    }

    // Helper untuk item media sederhana
    Widget _buildSimpleMediaItem(
      String title,
      String subtitle, {
      bool isLink = false,
    }) {
      // Kita gunakan Column dan ListTile
      return Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: _buildSimpleMediaLeading(),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(color: Colors.black54),
            ),
            trailing: isLink
                ? Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                    size: 20,
                  )
                : null,
            onTap: isLink ? () {} : null,
          ),
          Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
        ],
      );
    }

    return Column(
      children: [
        // Yellow Submarine
        _buildSimpleMediaItem('Yellow Submarine', 'Beatles'),

        // Don't Stop Me Now (Tambahkan chevron karena item kedua di foto memilikinya)
        _buildSimpleMediaItem('Don\'t Stop Me Now', 'Queen', isLink: true),

        // Billie Jean
        _buildSimpleMediaItem('Billie Jean', 'Michael Jackson'),
      ],
    );
  }

  // Simple Icon List (Something More Simple) - DIMODIFIKASI (Tablet Inset Dihapus)
  Widget _buildSimpleIconList() {
    // ❌ ERROR DIPERBAIKI: HAPUS FUNGSI LOKAL YANG TIDAK DIGUNAKAN DI SINI
    /*
    Widget leadingSimpleIconImageWidget() {
      return Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: framework7Purple,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Icon(mainIcon, color: Colors.white, size: 16)),
      );
    }
    */

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LIST MEDIA SEDERHANA DIPANGGIL DI BAWAH JUDUL UTAMA
        _buildSimpleMediaList(),

        // Bagian 'Tablet Inset' dihapus
      ],
    );
  }
}