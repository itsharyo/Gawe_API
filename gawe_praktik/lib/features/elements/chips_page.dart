import 'package:flutter/material.dart';

class ChipsPage extends StatelessWidget {
  ChipsPage({super.key});

  // Definisi Warna Statis yang Konsisten
  static const Color framework7Purple = Color(0xFF9147FF);
  static const Color lightPurpleBackground = Color(0xFFF7F2FF);
  static const Color dividerColor = Color(0xFFEFEFF4);

  // 1. HAPUS: Hapus definisi statis ini agar bisa didefinisikan ulang secara dinamis di build.
  // static const Color chipOutlineBorderColor = Color(0xFF333333); 
  
  static const Color solidOrange = Color(0xFFFF9800); // Warna Orange solid
  static const Color solidRed = Color(0xFFD32F2F);
  static const Color solidGreen = Color(0xFF388E3C);
  static const Color solidBlue = Color(0xFF1976D2);
  static const Color solidPink = Color(0xFFC2185B); // Warna Pink solid

  // Data Dummy (dibiarkan sama)
  final List<String> textChips = [
    'Example Chip',
    'Another Chip',
    'One More Chip',
    'Fourth Chip',
    'Last One',
  ];
  final List<Map<String, dynamic>> contactChips = [
    {'label': 'Jane Doe', 'avatar': 'https://picsum.photos/id/1011/40/40'},
    {'label': 'John Doe', 'avatar': 'https://picsum.photos/id/1025/40/40'},
    {'label': 'Adam Smith', 'avatar': 'https://picsum.photos/id/1012/40/40'},
    {'label': 'Jennifer', 'avatar': 'J', 'color': Colors.red},
    {'label': 'Chris', 'avatar': 'C', 'color': Colors.yellow},
    {'label': 'Kate', 'avatar': 'K', 'color': Colors.red},
  ];
  final List<Map<String, dynamic>> deletableChipsData = [
    {'label': 'Example Chip', 'type': 'text'},
    {
      'label': 'C Chris',
      'type': 'contact_letter',
      'avatar': 'C',
      'color': Colors.amber.shade700,
    },
    {
      'label': 'Jane Doe',
      'type': 'contact_image',
      'avatar': 'https://picsum.photos/id/1011/40/40',
    },
    {'label': 'One More Chip', 'type': 'text'},
    {
      'label': 'J Jennifer',
      'type': 'contact_letter',
      'avatar': 'J',
      'color': Colors.red.shade700,
    },
    {
      'label': 'Adam Smith',
      'type': 'contact_image',
      'avatar': 'https://picsum.photos/id/1012/40/40',
    },
  ];

  // --- Widget Pembantu: Judul Bagian (dibiarkan sama) ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
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

  // --- Widget Pembantu: Membangun Chip Dasar/Teks ---
  Widget _buildChip({
    required String label,
    Color backgroundColor = framework7Purple,
    Color textColor = Colors.black87,
    Widget? leading,
    Widget? trailing,
    BorderSide border = BorderSide.none,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
    VoidCallback? onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Chip(
        avatar: leading,
        label: Text(label, style: TextStyle(color: textColor, fontSize: 14)),
        deleteIcon: trailing,
        onDeleted: onDelete,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: border,
        ),
        padding: padding,
      ),
    );
  }

  // --- Widget Pembantu: Membangun Chip Kontak (dibiarkan sama) ---
  Widget _buildContactChip(Map<String, dynamic> contact) {
    bool hasImage = contact['avatar'].toString().startsWith('http');

    Widget avatarWidget;

    if (hasImage) {
      avatarWidget = CircleAvatar(
        backgroundImage: NetworkImage(contact['avatar']),
        radius: 12,
      );
    } else {
      avatarWidget = CircleAvatar(
        backgroundColor: contact['color'],
        radius: 12,
        child: Text(
          contact['avatar'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return _buildChip(
      label: contact['label'],
      leading: avatarWidget,
      backgroundColor: Colors.grey[200]!,
      textColor: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
    );
  }

  // --- Widget Pembantu: Membangun Chip yang Dapat Dihapus (Deletable) (dibiarkan sama) ---
  Widget _buildDeletableChip(Map<String, dynamic> data) {
    String type = data['type'];
    String label = data['label'];

    Widget? avatarWidget;
    Color chipBackgroundColor = Colors.transparent;
    Color textColor = Colors.black87;

    switch (type) {
      case 'text':
        chipBackgroundColor = lightPurpleBackground;
        textColor = Colors.black87;
        break;
      case 'contact_letter':
      case 'contact_image':
        chipBackgroundColor = lightPurpleBackground;
        textColor = Colors.black87;

        if (data.containsKey('avatar')) {
          if (data['avatar'].toString().startsWith('http')) {
            avatarWidget = CircleAvatar(
              backgroundImage: NetworkImage(data['avatar']),
              radius: 12,
            );
          } else {
            avatarWidget = CircleAvatar(
              backgroundColor: data['color'],
              radius: 12,
              child: Text(
                data['avatar'],
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            );
          }
        }
        break;
    }

    return _buildChip(
      label: label,
      leading: avatarWidget,
      backgroundColor: chipBackgroundColor.withOpacity(1.0),
      textColor: textColor,
      trailing: const Icon(Icons.close, size: 14, color: Colors.grey),
      onDelete: () => print('$label deleted'),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // 2. Mendefinisikan warna border secara dinamis berdasarkan tema
    final Color chipOutlineBorderColor = isDarkMode 
        ? Colors.white54 // Lebih terang jika Dark Mode
        : const Color(0xFF333333); // Lebih gelap jika Light Mode
    
    // Warna background disesuaikan (putih menjadi warna kartu di dark mode)
    final Color scaffoldBackground = isDarkMode 
        ? Theme.of(context).scaffoldBackgroundColor 
        : Colors.white;

    // Warna teks gelap disesuaikan dengan tema
    final Color dynamicTextColor = isDarkMode ? Colors.white70 : Colors.black87;


    return Scaffold(
      backgroundColor: scaffoldBackground,

      // --- AppBar (Header Halaman) ---
      appBar: AppBar(
        elevation: 0,
        // Gunakan warna tema card/scaffold agar konsisten
        backgroundColor: Theme.of(context).cardColor,
        foregroundColor: dynamicTextColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chips',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ----------------------------------------------------
            // 1. Chips With Text (Fill Chips)
            // ----------------------------------------------------
            _buildSectionTitle('Chips With Text'),
            Wrap(
              children: textChips.map((label) {
                return _buildChip(
                  label: label,
                  backgroundColor: framework7Purple.withOpacity(0.1),
                  textColor: dynamicTextColor, // Menggunakan warna dinamis
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                );
              }).toList(),
            ),

            // ----------------------------------------------------
            // 2. Outline Chips
            // ----------------------------------------------------
            _buildSectionTitle('Outline Chips'),
            Wrap(
              children: textChips.map((label) {
                return _buildChip(
                  label: label,
                  backgroundColor: scaffoldBackground, // Menggunakan background scaffold
                  textColor: dynamicTextColor, // Menggunakan warna dinamis
                  border: BorderSide(color: chipOutlineBorderColor, width: 1.0), // MENGGUNAKAN VARIABEL YANG BARU
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                );
              }).toList(),
            ),

            // ----------------------------------------------------
            // 3. Icon Chips
            // ----------------------------------------------------
            _buildSectionTitle('Icon Chips'),
            Wrap(
              children: [
                _buildChip(
                  label: 'Add Contact',
                  leading: Icon(
                    Icons.add_circle,
                    color: framework7Purple,
                    size: 18,
                  ),
                  backgroundColor: lightPurpleBackground,
                  textColor: dynamicTextColor, // Menggunakan warna dinamis
                ),
                _buildChip(
                  label: 'London',
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 18,
                  ),
                  backgroundColor: lightPurpleBackground,
                  textColor: dynamicTextColor, // Menggunakan warna dinamis
                ),
                _buildChip(
                  label: 'John Doe',
                  leading: Icon(Icons.person, color: Colors.red, size: 18),
                  backgroundColor: lightPurpleBackground,
                  textColor: dynamicTextColor, // Menggunakan warna dinamis
                ),
              ],
            ),

            // ----------------------------------------------------
            // 4. Contact Chips
            // ----------------------------------------------------
            _buildSectionTitle('Contact Chips'),
            Wrap(
              children: contactChips.map((contact) {
                return _buildContactChip(
                  contact,
                );
              }).toList(),
            ),

            // ----------------------------------------------------
            // 5. Deletable Chips / Tags
            // ----------------------------------------------------
            _buildSectionTitle('Deletable Chips / Tags'),
            Wrap(
              children: deletableChipsData.map((data) {
                return _buildDeletableChip(
                  data,
                );
              }).toList(),
            ),

            // ----------------------------------------------------
            // 6. Color Chips
            // Teks statis diubah menjadi dinamis
            // ----------------------------------------------------
            _buildSectionTitle('Color Chips'),
            Wrap(
              children: [
                // Baris 1: Red (Solid), Green (Solid), Blue (Solid)
                _buildChip(
                  label: 'Red Chip',
                  backgroundColor: solidRed,
                  textColor: dynamicTextColor, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
                _buildChip(
                  label: 'Green Chip',
                  backgroundColor: solidGreen,
                  textColor: dynamicTextColor, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
                _buildChip(
                  label: 'Blue Chip',
                  backgroundColor: solidBlue,
                  textColor: dynamicTextColor, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),

                // Baris 2: Orange (Solid), Pink (Solid), Red (Outline)
                _buildChip(
                  label: 'Orange Chip',
                  backgroundColor: solidOrange,
                  textColor: dynamicTextColor, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
                // Pink Chip (Solid)
                _buildChip(
                  label: 'Pink Chip',
                  backgroundColor: solidPink,
                  textColor: dynamicTextColor, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
                // Red Chip (Outline)
                _buildChip(
                  label: 'Red Chip',
                  backgroundColor: scaffoldBackground,
                  textColor: dynamicTextColor, 
                  border: BorderSide(color: chipOutlineBorderColor, width: 1.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),

                // Baris 3: Green (Outline), Blue (Outline), Orange (Outline)
                _buildChip(
                  label: 'Green Chip',
                  backgroundColor: scaffoldBackground,
                  textColor: dynamicTextColor, 
                  border: BorderSide(color: chipOutlineBorderColor, width: 1.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
                _buildChip(
                  label: 'Blue Chip',
                  backgroundColor: scaffoldBackground,
                  textColor: dynamicTextColor, 
                  border: BorderSide(color: chipOutlineBorderColor, width: 1.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
                _buildChip(
                  label: 'Orange Chip',
                  backgroundColor: scaffoldBackground,
                  textColor: dynamicTextColor, 
                  border: BorderSide(color: chipOutlineBorderColor, width: 1.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),

                // Baris 4: Pink (Outline)
                _buildChip(
                  label: 'Pink Chip',
                  backgroundColor: scaffoldBackground,
                  textColor: dynamicTextColor, 
                  border: BorderSide(color: chipOutlineBorderColor, width: 1.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}