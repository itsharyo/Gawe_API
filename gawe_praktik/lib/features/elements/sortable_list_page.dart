import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
const Color iconBackground = Color(0xFFF2F2F7);

// Data Dummy untuk List Item
class ListItem {
  final int id;
  final String name;
  final String subtitle;
  final String? price;
  final String? assetPath; // Digunakan untuk jalur gambar lokal
  final IconData? icon;

  ListItem({
    required this.id,
    required this.name,
    required this.subtitle,
    this.price,
    this.assetPath, // Aset lokal
    this.icon,
  });
}

// Data List A: Kontak dengan Icon (Gambar atas)
final List<ListItem> listAData = [
  ListItem(
    id: 1,
    name: '1 Jenna Smith',
    subtitle: 'CEO',
    icon: Icons.camera_alt,
  ),
  ListItem(
    id: 2,
    name: '2 John Doe',
    subtitle: 'Director',
    icon: Icons.camera_alt,
  ),
  ListItem(
    id: 3,
    name: '3 John Doe',
    subtitle: 'Developer',
    icon: Icons.camera_alt,
  ),
  ListItem(
    id: 4,
    name: '4 Aaron Darling',
    subtitle: 'Manager',
    icon: Icons.camera_alt,
  ),
  ListItem(
    id: 5,
    name: '5 Calvin Johnson',
    subtitle: 'Accounter',
    icon: Icons.camera_alt,
  ),
  ListItem(
    id: 6,
    name: '6 John Smith',
    subtitle: 'SEO',
    icon: Icons.camera_alt,
  ),
  ListItem(id: 7, name: '7 Chloe', subtitle: 'Manager', icon: Icons.camera_alt),
];

// Data List B: Media/Musik (MENGGUNAKAN JALUR ASSET LOKAL)
final List<ListItem> listBData = [
  ListItem(
    id: 101,
    name: 'Yellow Submarine',
    subtitle: 'Beatles\nLorem ipsum dolor sit amet, consectetur elit. Nulla...',
    price: '\$15',
    assetPath: 'assets/sortable1.jpg', // GANTI JALUR INI!
  ),
  ListItem(
    id: 102,
    name: 'Don\'t Stop Me Now',
    subtitle: 'Queen\nLorem ipsum dolor sit amet, consectetur elit. Nulla...',
    price: '\$22',
    assetPath: 'assets/sortable2.jpg', // GANTI JALUR INI!
  ),
  ListItem(
    id: 103,
    name: 'Billie Jean',
    subtitle:
        'Michael Jackson\nLorem ipsum dolor sit amet, consectetur elit. Nulla...',
    price: '\$16',
    assetPath: 'assets/sortable3.jpg', // GANTI JALUR INI!
  ),
];

class SortableListPage extends StatefulWidget {
  const SortableListPage({super.key});

  @override
  State<SortableListPage> createState() => _SortableListPageState();
}

class _SortableListPageState extends State<SortableListPage> {
  bool isSortingEnabled = false;

  late List<ListItem> _listA;
  late List<ListItem> _listB;
  late List<ListItem> _listC;

  @override
  void initState() {
    super.initState();
    _listA = List.from(listAData);
    _listB = List.from(listBData);
    _listC = List.from(listAData);
  }

  // --- Widget Pembantu: Membuat Ikon List Item (Gaya F7) ---
  Widget _buildListItemIcon(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: iconBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: framework7Purple,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 14),
        ),
      ),
    );
  }

  // --- Widget Pembantu: Item Daftar Dasar/Kontak ---
  Widget _buildSimpleListItem(ListItem item, {bool isOpposite = false}) {
    final Key itemKey = ValueKey(item.id);

    final Widget dragHandle = isSortingEnabled
        ? const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.drag_handle, color: Colors.black54),
          )
        : const SizedBox(width: 10);

    final Widget listTileContent = ListTile(
      contentPadding: EdgeInsets.zero,
      leading: isOpposite && isSortingEnabled ? dragHandle : null,
      title: Row(
        children: [
          _buildListItemIcon(item.icon!),
          const SizedBox(width: 12),
          Text(
            item.name,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.subtitle,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          if (!isOpposite && isSortingEnabled) dragHandle,
        ],
      ),
      onTap: () {
        if (!isSortingEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Anda mengklik: ${item.name}')),
          );
        }
      },
    );

    return Container(
      key: itemKey,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          listTileContent,
          const Divider(
            height: 1,
            thickness: 0.5,
            color: dividerColor,
            indent: 48,
          ),
        ],
      ),
    );
  }

  // --- Widget Pembantu: Item Daftar Media/Musik (MENGGUNAKAN IMAGE.ASSET) ---
  Widget _buildMediaListItem(ListItem item) {
    final Key itemKey = ValueKey(item.id);

    final Widget dragHandle = isSortingEnabled
        ? const Icon(Icons.drag_handle, color: Colors.black54)
        : const SizedBox();

    return Container(
      key: itemKey,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: item.assetPath != null
                  ? Image.asset(
                      // <-- MEMUAT DARI ASSET LOKAL
                      item.assetPath!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
            ),
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Text(
              item.subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              maxLines: 2,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.price!,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                if (isSortingEnabled) dragHandle,
              ],
            ),
            onTap: () {
              if (!isSortingEnabled) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Anda memutar: ${item.name}')),
                );
              }
            },
          ),
          const Divider(height: 1, thickness: 0.5, color: dividerColor),
        ],
      ),
    );
  }

  // --- Fungsi Reorder (TETAP SAMA) ---
  void _onReorderA(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _listA.removeAt(oldIndex);
      _listA.insert(newIndex, item);
    });
  }

  void _onReorderB(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _listB.removeAt(oldIndex);
      _listB.insert(newIndex, item);
    });
  }

  void _onReorderC(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = _listC.removeAt(oldIndex);
      _listC.insert(newIndex, item);
    });
  }

  // --- Widget untuk List yang Dapat Diurutkan (ReorderableListView) ---
  Widget _buildSortableList({
    required List<ListItem> data,
    required Function(int, int) onReorder,
    required Widget Function(ListItem, {bool isOpposite}) itemBuilder,
    bool isOpposite = false,
  }) {
    if (isSortingEnabled) {
      return ReorderableListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        onReorder: onReorder,
        buildDefaultDragHandles: false,
        children: data.map((item) {
          final Widget listItem = itemBuilder(item, isOpposite: isOpposite);

          return ReorderableDragStartListener(
            key: ValueKey(item.id),
            index: data.indexOf(item),
            enabled: isSortingEnabled,
            child: listItem,
          );
        }).toList(),
      );
    } else {
      return Column(
        children: data
            .map((item) => itemBuilder(item, isOpposite: isOpposite))
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar ---
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
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Sortable List',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
            actions: [
              // Tombol Toggle
              TextButton(
                onPressed: () {
                  setState(() {
                    isSortingEnabled = !isSortingEnabled;
                  });
                },
                child: Text(
                  isSortingEnabled ? 'Done' : 'Toggle',
                  style: TextStyle(
                    color: framework7Purple,
                    fontWeight: isSortingEnabled
                        ? FontWeight.bold
                        : FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Just click "Toggle" button on navigation bar to enable sorting',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),

            // --- LIST A: Kontak Sederhana (Handle di kanan) ---
            _buildSortableList(
              data: _listA,
              onReorder: _onReorderA,
              itemBuilder: (item, {isOpposite = false}) =>
                  _buildSimpleListItem(item),
            ),

            // --- LIST B: Media/Musik (Handle di kanan) ---
            const SizedBox(height: 12),
            _buildSortableList(
              data: _listB,
              onReorder: _onReorderB,
              itemBuilder: (item, {isOpposite = false}) =>
                  _buildMediaListItem(item),
            ),

            // --- LIST C: Opposite Side (Handle di kiri) ---
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(
                'Opposite Side',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: framework7Purple,
                ),
              ),
            ),
            _buildSortableList(
              data: _listC,
              onReorder: _onReorderC,
              itemBuilder: (item, {isOpposite = true}) =>
                  _buildSimpleListItem(item, isOpposite: true),
              isOpposite: true,
            ),
          ],
        ),
      ),
    );
  }
}
