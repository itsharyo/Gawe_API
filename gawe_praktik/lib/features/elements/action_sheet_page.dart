import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ActionSheetPage extends StatelessWidget {
  ActionSheetPage({super.key});

  // Definisi Warna Framework7
  static const Color framework7Purple = Color(0xFF9147FF);
  static const Color lightPurpleBackground = Color(0xFFF7F2FF);
  static const Color dividerColor = Color(0xFFEFEFF4);
  static const Color blockBorderColor = Color(0xFFE0E0E0);
  static const Color primaryButtonColor = Color(0xFF7B1FA2);

  final List<String> buttonTitles = ['One group', 'Two groups'];

  @override
  Widget build(BuildContext context) {
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
              'Action Sheet',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 24),

            // --- KOTAK PEMBUNGKUS TOMBOL ---
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: lightPurpleBackground,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: blockBorderColor, width: 1.0),
              ),
              child: Column(
                children: [
                  // Baris Tombol Group (One group & Two groups)
                  Row(
                    children: buttonTitles.map((title) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: title == 'One group' ? 8.0 : 0,
                          ),
                          child: _buildActionButton(
                            context,
                            title,
                            height: 40.0,
                            onTap: () => _showFullGroupActionSheet(context),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),

                  // Tombol Action Grid
                  _buildActionButton(
                    context,
                    'Action Grid',
                    height: 40.0,
                    onTap: () => _showGridActionSheet(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // --- Judul Blok Informasi ---
            const Text(
              'Action Sheet To Popover',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: framework7Purple,
              ),
            ),
            const SizedBox(height: 8),

            // --- Blok Informasi (Action Sheet To Popover) ---
            _buildInfoBlock(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Widget Pembantu: Tombol Ungu ---
  Widget _buildActionButton(
    BuildContext context,
    String title, {
    required double height,
    required VoidCallback onTap,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: framework7Purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
          minimumSize: Size(double.infinity, height),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  // --- Widget Pembantu: Blok Informasi ---
  Widget _buildInfoBlock(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: lightPurpleBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text.rich(
        TextSpan(
          style: DefaultTextStyle.of(context).style.copyWith(
            fontSize: 16,
            height: 1.4,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
          children: <TextSpan>[
            const TextSpan(
              text:
                  'Action Sheet can be automatically converted to Popover (for tablets). This button will open Popover on tablets and Action Sheet on phones: ',
            ),
            TextSpan(
              text: 'Actions',
              style: const TextStyle(
                color: framework7Purple,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _showSimpleGroupActionSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  // --- LOGIKA ACTION SHEET ---

  // Tipe 1: Action Sheet Grup Penuh ("One group" / "Two groups")
  void _showFullGroupActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Judul "Do something"
              ListTile(
                title: Text(
                  'Do something',
                  style: TextStyle(color: framework7Purple, fontSize: 14),
                ),
                onTap: () {},
              ),
              // Button 1
              ListTile(
                title: Text(
                  'Button 1',
                  style: TextStyle(
                    color: primaryButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); /* Aksi Button 1 */
                },
              ),
              // Button 2
              ListTile(
                title: Text(
                  'Button 2',
                  style: TextStyle(
                    color: primaryButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); /* Aksi Button 2 */
                },
              ),
              // Cancel
              ListTile(
                title: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Tipe 2: Action Sheet Grid ("Action Grid")
  void _showGridActionSheet(BuildContext context) {
    // Data dummy untuk Action Grid
    final List<Map<String, dynamic>> gridItems = [
      {
        'label': 'Button 1',
        'icon': Icons.person,
        'image': 'https://picsum.photos/id/1005/60/60',
      },
      {
        'label': 'Button 2',
        'icon': Icons.image,
        'image': 'https://picsum.photos/id/237/60/60',
      },
      {
        'label': 'Button 3',
        'icon': Icons.camera,
        'image': 'https://picsum.photos/id/177/60/60',
      },
      {
        'label': 'Button 1',
        'icon': Icons.videocam,
        'image': 'https://picsum.photos/id/1084/60/60',
      },
      {
        'label': 'Button 2',
        'icon': Icons.audiotrack,
        'image': 'https://picsum.photos/id/1018/60/60',
      },
      {
        'label': 'Button 3',
        'icon': Icons.settings,
        'image': 'https://picsum.photos/id/1025/60/60',
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Center(
          // 💡 PERBAIKAN 1: Memusatkan ConstrainedBox untuk membatasi lebar
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ), // Batasi lebar maksimum modal grid
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  // Menambahkan bayangan untuk tampilan melayang
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                // Menggunakan Column untuk menampung GridView dan Divider
                mainAxisSize: MainAxisSize.min,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3, // Hanya item baris pertama (Button 1, 2, 3)
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final item = gridItems[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[200],
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(
                                        item['icon'],
                                        size: 30,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['label'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  // 💡 PERBAIKAN 2: Garis Pembatas di Tengah Grid
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFE0E0E0),
                  ),
                  const SizedBox(height: 8), // Sedikit jarak setelah divider

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3, // Hanya item baris kedua (Button 1, 2, 3)
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.8,
                        ),
                    itemBuilder: (context, index) {
                      final item =
                          gridItems[index +
                              3]; // Ambil item dari indeks 3 dan seterusnya
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              item['image'],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[200],
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 60,
                                    height: 60,
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Icon(
                                        item['icon'],
                                        size: 30,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['label'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Tipe 3: Action Sheet Grup Sederhana (Tautan "Actions")
  void _showSimpleGroupActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Judul "Do something"
              ListTile(
                title: Text(
                  'Do something',
                  style: TextStyle(color: framework7Purple, fontSize: 14),
                ),
                onTap: () {},
              ),
              // Button 1
              ListTile(
                title: Text(
                  'Button 1',
                  style: TextStyle(
                    color: primaryButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); /* Aksi Button 1 */
                },
              ),
              // Button 2
              ListTile(
                title: Text(
                  'Button 2',
                  style: TextStyle(
                    color: primaryButtonColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); /* Aksi Button 2 */
                },
              ),

              // Garis Pembatas di Tengah (Antara Button 2 dan Cancel)
              const Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),

              // Cancel
              ListTile(
                title: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
