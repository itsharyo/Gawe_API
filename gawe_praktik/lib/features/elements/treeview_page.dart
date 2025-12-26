import 'package:flutter/material.dart';
import 'dart:async'; // Diperlukan untuk _showMultipleAlerts

// =======================================================
// BAGIAN 1: MODEL DATA (dari data_model.dart)
// =======================================================

// Model Data untuk setiap item di TreeView
class TreeItemData {
  final String title;
  final IconData icon;
  final List<TreeItemData> children;
  final bool hasCheckbox;
  final bool isLink;
  final bool isSelectable;

  TreeItemData({
    required this.title,
    required this.icon,
    this.children = const [],
    this.hasCheckbox = false,
    this.isLink = false,
    this.isSelectable = false,
  });
}

// Model Data untuk Grouping (Header)
class TreeGroup {
  final String title;
  final List<TreeItemData> data;

  TreeGroup({required this.title, required this.data});
}

// Data Sampel yang DIKELOMPOKKAN
final List<TreeGroup> groupedTreeData = [
  // --- Group 1: Basic Tree View ---
  TreeGroup(
    title: "Basic tree view",
    data: [
      TreeItemData(
        title: "Item 1",
        icon: Icons.folder_open,
        children: [
          TreeItemData(
            title: "Sub Item 1",
            icon: Icons.folder,
            children: [
              TreeItemData(title: "Sub Sub Item 1", icon: Icons.description),
              TreeItemData(title: "Sub Sub Item 2", icon: Icons.description),
            ],
          ),
          TreeItemData(
            title: "Sub Item 2",
            icon: Icons.folder,
            children: [
              TreeItemData(title: "Sub Sub Item 1", icon: Icons.description),
              TreeItemData(title: "Sub Sub Item 2", icon: Icons.description),
            ],
          ),
        ],
      ),
      TreeItemData(
        title: "Item 2",
        icon: Icons.folder_open,
        children: [
          TreeItemData(
            title: "Sub Item 1",
            icon: Icons.folder,
            children: [
              TreeItemData(title: "Sub Sub Item 1", icon: Icons.description),
              TreeItemData(title: "Sub Sub Item 2", icon: Icons.description),
            ],
          ),
          TreeItemData(
            title: "Sub Item 2",
            icon: Icons.folder,
            children: [
              TreeItemData(title: "Sub Sub Item 1", icon: Icons.description),
              TreeItemData(title: "Sub Sub Item 2", icon: Icons.description),
            ],
          ),
        ],
      ),
      TreeItemData(title: "Item 3", icon: Icons.description),
    ],
  ),

  // --- Group 2: With Icons
  TreeGroup(
    title: "With icons",
    data: [
      TreeItemData(
        title: "images",
        icon: Icons.folder,
        children: [
          TreeItemData(title: "avatar.png", icon: Icons.image),
          TreeItemData(title: "background.jpg", icon: Icons.image),
        ],
      ),
      TreeItemData(
        title: "documents",
        icon: Icons.folder,
        children: [
          TreeItemData(title: "cv.docx", icon: Icons.description),
          TreeItemData(title: "info.docx", icon: Icons.description),
        ],
      ),
      TreeItemData(title: ".gitignore", icon: Icons.code),
      TreeItemData(title: "index.html", icon: Icons.description),
    ],
  ),

  // --- Group 3: With Checkboxes ---
  TreeGroup(
    title: "With checkboxes",
    data: [
      TreeItemData(
        title: "images",
        icon: Icons.folder,
        hasCheckbox: true,
        children: [
          TreeItemData(
            title: "avatar.png",
            icon: Icons.image,
            hasCheckbox: true,
          ),
          TreeItemData(
            title: "background.jpg",
            icon: Icons.image,
            hasCheckbox: true,
          ),
        ],
      ),
      TreeItemData(
        title: "documents",
        icon: Icons.folder,
        hasCheckbox: true,
        children: [
          TreeItemData(
            title: "cv.docx",
            icon: Icons.description,
            hasCheckbox: true,
          ),
          TreeItemData(
            title: "info.docx",
            icon: Icons.description,
            hasCheckbox: true,
          ),
        ],
      ),
      TreeItemData(title: ".gitignore", icon: Icons.code, hasCheckbox: true),
      TreeItemData(
        title: "index.html",
        icon: Icons.description,
        hasCheckbox: true,
      ),
    ],
  ),

  // --- Group 4: Whole item as toggle ---
  TreeGroup(
    title: "Whole item as toggle",
    data: [
      TreeItemData(
        title: "images",
        icon: Icons.folder,
        children: [
          TreeItemData(title: "avatar.png", icon: Icons.image),
          TreeItemData(title: "background.jpg", icon: Icons.image),
        ],
      ),
      TreeItemData(
        title: "documents",
        icon: Icons.folder,
        children: [
          TreeItemData(title: "cv.docx", icon: Icons.description),
          TreeItemData(title: "info.docx", icon: Icons.description),
        ],
      ),
      TreeItemData(title: ".gitignore", icon: Icons.code),
      TreeItemData(title: "index.html", icon: Icons.description),
    ],
  ),

  // --- Group 5: Selectable ---
  TreeGroup(
    title: "Selectable",
    data: [
      TreeItemData(
        title: "images",
        icon: Icons.folder,
        children: [
          TreeItemData(
            title: "avatar.png",
            icon: Icons.image,
            isSelectable: true,
          ),
          TreeItemData(
            title: "background.jpg",
            icon: Icons.image,
            isSelectable: true,
          ),
        ],
      ),
      TreeItemData(
        title: "documents",
        icon: Icons.folder,
        children: [
          TreeItemData(
            title: "cv.docx",
            icon: Icons.description,
            isSelectable: true,
          ),
          TreeItemData(
            title: "info.docx",
            icon: Icons.description,
            isSelectable: true,
          ),
        ],
      ),
      TreeItemData(title: ".gitignore", icon: Icons.code, isSelectable: true),
      TreeItemData(
        title: "index.html",
        icon: Icons.description,
        isSelectable: true,
      ),
    ],
  ),

  // --- Group 6: Preload children (User List) ---
  TreeGroup(
    title: "Preload children",
    data: [
      TreeItemData(
        title: "Users",
        icon: Icons.people,
        children: [
          TreeItemData(title: "John Doe", icon: Icons.person),
          TreeItemData(title: "Jane Doe", icon: Icons.person),
          TreeItemData(title: "Calvin Johnson", icon: Icons.person),
        ],
      ),
    ],
  ),

  // --- Group 7: With links (Modal/Popup Berantai) ---
  TreeGroup(
    title: "With links",
    data: [
      TreeItemData(
        title: "Modals",
        icon: Icons.dashboard,
        children: [
          // Item ini yang akan memicu Modal berantai
          TreeItemData(title: "Popup", icon: Icons.link, isLink: true),
          TreeItemData(title: "Dialog", icon: Icons.link, isLink: true),
          TreeItemData(title: "Action Sheet", icon: Icons.link, isLink: true),
        ],
      ),
      TreeItemData(
        title: "Navigation Bars",
        icon: Icons.dashboard,
        children: [
          TreeItemData(title: "Navbar", icon: Icons.link, isLink: true),
          TreeItemData(
            title: "Toolbar & Tabbar",
            icon: Icons.link,
            isLink: true,
          ),
        ],
      ),
    ],
  ),
];

// =======================================================
// BAGIAN 2: UI SCREEN (dari main.dart)
// =======================================================

// 🚀 NAMA KELAS DIUBAH MENJADI TreeviewPage
class TreeviewPage extends StatelessWidget {
  const TreeviewPage({super.key});

  Widget _buildSectionHeader(String title, MaterialColor color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          color: color[700],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan tema dari MaterialApp utama, bukan mendefinisikan baru
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        // Menyesuaikan dengan gaya AppBar di elemen lain
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Treeview'),
        // Hapus style kustom agar mengikuti tema utama
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (groupedTreeData.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Data TreeView kosong. Pastikan data_model.dart terisi.',
                ),
              )
            else
              ...groupedTreeData.expand((group) {
                return [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 0.0,
                      bottom: 8.0,
                    ),
                    // Menggunakan warna primer dari tema
                    child: _buildSectionHeader(group.title, Colors.deepPurple),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: group.data.map((item) {
                        return CustomTreeNode(item: item, level: 0);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                ];
              }).toList(),
          ],
        ),
      ),
    );
  }
}

// =======================================================
// BAGIAN 3: WIDGET NODE (dari main.dart)
// =======================================================

class CustomTreeNode extends StatefulWidget {
  final TreeItemData item;
  final int level;

  const CustomTreeNode({super.key, required this.item, required this.level});

  @override
  State<CustomTreeNode> createState() => _CustomTreeNodeState();
}

class _CustomTreeNodeState extends State<CustomTreeNode>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  bool _isChecked = false;
  bool _isSelected = false;
  Color _hoverColor = Colors.transparent;

  late AnimationController _rotationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: widget.item.children.isNotEmpty ? 1.0 : 0.0,
    );
    _iconAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(_rotationController);

    _isExpanded = widget.item.children.isNotEmpty;
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _showModal6(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (modalContext) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.95,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(modalContext),
              ),
              title: const Text(
                'New View (Push View)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popup is a modal window with any HTML content that pops up over App\'s main content. Popup as all other overlays is part of so called "Temporary Views".',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showModal2(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: const Text('Open Popup'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        _showModal3(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: const Text('Create Dynamic Popup'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Swipe To Close',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Popup can be closed with swipe to top or bottom:',
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        _showModal4(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: const Text('Swipe To Close'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Or it can be closed with swipe on special swipe handler and, for example, only to bottom:',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        _showModal5(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: const Text('With Swipe Handler'),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Push View',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Popup can push view behind. By default it has effect only when "safe-area-inset-top" is more than zero (iOS fullscreen webapp or iOS cordova app)',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        _showModal6(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      child: const Text('Popup Push (Recursive)'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showModal5(BuildContext context) {
    const String fullText =
        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse faucibus mauris leo, eu bibendum neque congue non. Ut leo mauris, eleifend eu commodo a, egestas ac urna. Maecenas in lacus faucibus, viverra ipsum pulvinar, molestie arcu. Etiam lacinia venenatis dignissim. Suspendisse non nisl semper tellus malesuada suscipit eu et eros. Nulla eu enim quis quam elementum vulputate. Mauris ornare consequat nunc viverra pellentesque. Aenean semper eu massa sit amet aliquam. Integer et neque sed libero mollis elementum at vitae ligula. Vestibulum pharetra sed libero sed porttitor. Suspendisse a faucibus lectus.
Duis ut mauris sollicitudin, venenatis nisi sed, luctus ligula. Phasellus blandit nisl ut lorem semper pharetra. Nullam tortor nibh, suscipit in consequat vel, feugiat sed quam. Nam risus libero, auctor vel tristique ac, malesuada ut ante. Sed molestie, est in eleifend sagittis, leo tortor ullamcorper erat, at vulputate eros sapien nec libero. Mauris dapibus laoreet nibh quis bibendum. Fusce dolor sem, suscipit in iaculis id, pharetra at urna. Pellentesque tempor congue massa quis faucibus. Vestibulum nunc eros, convallis blandit dui sit amet, gravida adipiscing libero.
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse faucibus mauris leo, eu bibendum neque congue non. Ut leo mauris, eleifend eu commodo a, egestas ac urna. Maecenas in lacus faucibus, viverra ipsum pulvinar, molestie arcu. Etiam lacinia venenatis dignissim. Suspendisse non nisl semper tellus malesuada suscipit eu et eros. Nulla eu enim quis quam elementum vulputate. Mauris ornare consequat nunc viverra pellentesque. Aenean semper eu massa sit amet aliquam. Integer et neque sed libero mollis elementum at vitae ligula. Vestibulum pharetra sed libero sed porttitor. Suspendisse a faucibus lectus.
Duis ut mauris sollicitudin, venenatis nisi sed, luctus ligula. Phasellus blandit nisl ut lorem semper pharetra. Nullam tortor nibh, suscipit in consequat vel, feugiat sed quam. Nam risus libero, auctor vel tristique ac, malesuada ut ante. Sed molestie, est in eleifend sagittis, leo tortor ullamcorper erat, at vulputate eros sapien nec libero. Mauris dapibus laoreet nibh quis bibendum. Fusce dolor sem, suscipit in iaculis id, pharetra at urna. Pellentesque tempor congue massa quis faucibus. Vestibulum nunc eros, convallis blandit dui sit amet, gravida adipiscing libero.''';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Hello!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    fullText,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
            ],
          ),
        );
      },
    );
  }

  void _showModal4(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          padding: const EdgeInsets.only(
            top: 16,
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Swipe To Close',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Close',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Swipe me up or down',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showModal3(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          titlePadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: const EdgeInsets.only(
            top: 0,
            left: 20,
            right: 20,
            bottom: 0,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dynamic Popup'),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ],
          ),
          content: const SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This popup was created dynamically',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: 10),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse faucibus mauris leo, eu bibendum neque congue non. Ut leo mauris, eleifend eu commodo a, egestas ac urna. Maecenas in lacus faucibus, viverra ipsum pulvinar, molestie arcu. Etiam lacinia venenatis dignissim. Suspendisse non nisl semper tellus malesuada suscipit eu et eros. Nulla eu enim quis quam elementum vulputate. Mauris ornare consequat nunc viverra pellentesque. Aenean semper eu massa sit amet aliquam. Integer et neque sed libero mollis elementum at vitae ligula. Vestibulum pharetra sed libero sed porttitor. Suspendisse a faucibus lectus.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          actions: const [],
        );
      },
    );
  }

  void _showModal2(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Popup Title'),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
          content: const SingleChildScrollView(
            child: Text(
              'Here comes popup. You can put here anything, even independent view with its own navigation. Also not, that by default popup looks a bit different on iPhone/iPod and iPad, on iPhone it is fullscreen.\n\n'
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse faucibus mauris leo, eu bibendum neque congue non. Ut leo mauris, eleifend eu commodo a, egestas ac urna. Maecenas in lacus faucibus, viverra ipsum pulvinar, molestie arcu. Etiam lacinia venenatis dignissim. Suspendisse non nisl semper tellus malesuada suscipit eu et eros. Nulla eu enim quis quam elementum vulputate. Mauris ornare consequat nunc viverra pellentesque. Aenean semper eu massa sit amet aliquam. Integer et neque sed libero mollis elementum at vitae ligula. Vestibulum pharetra sed libero sed porttitor. Suspendisse a faucibus lectus.\n\n'
              'Duis ut mauris sollicitudin, venenatis nisi sed, luctus ligula. Phasellus blandit nisl ut lorem semper pharetra. Nullam tortor nibh, suscipit in consequat vel, feugiat sed quam. Nam risus libero, auctor vel tristique ac, malesuada ut ante. Sed molestie, est in eleifend sagittis, leo tortor ullamcorper erat, at vulputate eros sapien nec libero. Mauris dapibus laoreet nibh quis bibendum. Fusce dolor sem, suscipit in iaculis id, pharetra at urna. Pellentesque tempor congue massa quis faucibus. Vestibulum nunc eros, convallis blandit dui sit amet, gravida adipiscing libero.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showModal1(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.all(20),
          title: const Text('Popup'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Popup is a modal window with any HTML content that pops up over App\'s main content. Popup as all other overlays is part of so called "Temporary Views".',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showModal2(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Open Popup'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showModal3(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Create Dynamic Popup'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Swipe To Close',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('Popup can be closed with swipe to top or bottom:'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showModal4(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Swipe To Close'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Or it can be closed with swipe on special swipe handler and, for example, only to bottom:',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showModal5(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('With Swipe Handler'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Push View',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Popup can push view behind. By default it has effect only when "safe-area-inset-top" is more than zero (iOS fullscreen webapp or iOS cordova app)',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showModal6(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                child: const Text('Popup Push'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _handleTap(BuildContext context) {
    setState(() {
      if (widget.item.isLink) {
        if (widget.item.title == 'Popup') {
          _showModal1(context);
        } else if (widget.item.title == 'Dialog') {
          // 🚀 PERBAIKAN: Navigasi ke DialogScreen yang sudah ada di file ini
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DialogScreen()),
          );
        } else {
          debugPrint('Link diklik: ${widget.item.title}');
        }
        return;
      }

      if (widget.item.hasCheckbox) {
        _isChecked = !_isChecked;
      }

      if (widget.item.isSelectable) {
        _isSelected = !_isSelected;
      }

      if (widget.item.children.isNotEmpty) {
        _isExpanded = !_isExpanded;
        if (_isExpanded) {
          _rotationController.forward();
        } else {
          _rotationController.reverse();
        }
      }
    });
  }

  void _handleCheckboxChange(bool? newValue) {
    if (newValue != null) {
      setState(() {
        _isChecked = newValue;
      });
    }
  }

  Color get _rowBackgroundColor {
    if (_hoverColor != Colors.transparent) {
      return Colors.grey.shade100;
    }
    if (widget.item.isSelectable && _isSelected) {
      return Colors.deepPurple.shade50;
    }
    return Colors.grey.shade50;
  }

  @override
  Widget build(BuildContext context) {
    final double indent = widget.level * 20.0;

    final Widget verticalLine = Container(
      width: 4.0,
      height: 28.0,
      color: (widget.item.children.isNotEmpty && _isExpanded) ||
              (widget.item.isSelectable && _isSelected)
          ? Colors.deepPurple.shade400
          : Colors.transparent,
    );

    final Widget arrowIcon = widget.item.children.isNotEmpty
        ? RotationTransition(
            turns: _iconAnimation,
            child: const Icon(
              Icons.arrow_right,
              size: 24,
              color: Colors.black54,
            ),
          )
        : const SizedBox(width: 24);

    final content = MouseRegion(
      cursor: widget.item.isLink ||
              widget.item.hasCheckbox ||
              widget.item.isSelectable ||
              widget.item.children.isNotEmpty
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        setState(() => _hoverColor = Colors.grey.shade100);
      },
      onExit: (_) {
        setState(() => _hoverColor = Colors.transparent);
      },
      child: Container(
        color: _rowBackgroundColor,
        child: InkWell(
          onTap: () => _handleTap(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 16.0),
            child: Row(
              children: [
                SizedBox(width: indent),
                verticalLine,
                arrowIcon,
                if (widget.item.hasCheckbox)
                  Checkbox(
                    value: _isChecked,
                    onChanged: _handleCheckboxChange,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Colors.deepPurple,
                  ),
                if (!widget.item.hasCheckbox) const SizedBox(width: 4),
                Icon(
                  widget.item.icon,
                  size: 20,
                  color: widget.item.isLink ? Colors.blue : Colors.black87,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: widget.level == 0
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: widget.item.isLink ? Colors.blue : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        content,
        if (widget.item.children.isNotEmpty)
          ClipRect(
            child: Align(
              heightFactor: _isExpanded ? 1.0 : 0.0,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.item.children.map((child) {
                  return CustomTreeNode(
                    key: ValueKey('${child.title}_${widget.level + 1}'),
                    item: child,
                    level: widget.level + 1,
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}

// =======================================================
// BAGIAN 4: SCREEN DIALOG (dari main.dart)
// =======================================================

class DialogScreen extends StatefulWidget {
  const DialogScreen({super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  Widget _buildCustomAlertDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
      actions: actions,
      contentPadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
      actionsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
    );
  }

  // --- 1. ALERT ---
  Future<void> _showAlert({String content = 'Hello!'}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return _buildCustomAlertDialog(
          title: 'Framework7',
          content: content,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- 2. CONFIRM ---
  void _showConfirm() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return _buildCustomAlertDialog(
          title: 'Framework7',
          content: 'Are you feel good today?',
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _showConfirmResult();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmResult() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return _buildCustomAlertDialog(
          title: 'Framework7',
          content: 'Great!',
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  // --- 3. PROMPT ---
  void _showPrompt() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Framework7',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please enter your name:',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your Name',
                  isDense: true,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                String input = controller.text;
                Navigator.of(dialogContext).pop();
                _showAlert(content: 'Are you sure that your name is ?: $input');
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple, fontSize: 16),
              ),
            ),
          ],
          contentPadding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
          actionsPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        );
      },
    );
  }

  void _showMultipleAlerts() async {
    await _showAlert(content: 'Alert 1: Click OK to open Alert 2.');
    await _showAlert(content: 'Alert 2: Click OK to open Alert 3.');
    await _showAlert(content: 'Alert 3: Stack finished!');
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24.0,
        bottom: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildDialogButton(
    BuildContext context,
    String text, {
    VoidCallback? onPressed,
  }) {
    VoidCallback? currentOnPressed;

    if (text == 'Alert') {
      currentOnPressed = _showAlert;
    } else if (text == 'Confirm') {
      currentOnPressed = _showConfirm;
    } else if (text == 'Prompt') {
      currentOnPressed = _showPrompt;
    } else {
      currentOnPressed = onPressed ??
          () {
            debugPrint('$text diklik!');
          };
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: currentOnPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(text, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget _buildFullWidthButton(
    BuildContext context,
    String text, {
    VoidCallback? onPressed,
  }) {
    VoidCallback? currentOnPressed;

    if (text == 'Open Multiple Alerts') {
      currentOnPressed = _showMultipleAlerts;
    } else {
      currentOnPressed = onPressed ??
          () {
            debugPrint('$text diklik!');
          };
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton(
        onPressed: currentOnPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Dialog', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'There are 1:1 replacements of native Alert, Prompt and Confirm modals. They support callbacks, have very easy api and can be combined with each other. Check these examples:',
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _buildDialogButton(context, 'Alert'),
                  _buildDialogButton(context, 'Confirm'),
                  _buildDialogButton(context, 'Prompt'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _buildDialogButton(context, 'Login'),
                  _buildDialogButton(context, 'Password'),
                ],
              ),
            ),
            _buildSectionHeader('Vertical Buttons'),
            _buildFullWidthButton(context, 'Vertical Buttons'),
            _buildSectionHeader('Preloader Dialog'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _buildDialogButton(context, 'Preloader'),
                  _buildDialogButton(context, 'Custom Text'),
                ],
              ),
            ),
            _buildSectionHeader('Progress Dialog'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _buildDialogButton(context, 'Infinite'),
                  _buildDialogButton(context, 'Determined'),
                ],
              ),
            ),
            _buildSectionHeader('Dialogs Stack'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'This feature doesn\'t allow to open multiple dialogs at the same time, and will automatically open next dialog when you close the current one. Such behavior is similar to browser native dialogs:',
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            _buildFullWidthButton(context, 'Open Multiple Alerts'),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
