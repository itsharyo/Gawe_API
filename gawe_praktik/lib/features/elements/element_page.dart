import 'package:flutter/material.dart';
import 'about_page.dart';
import 'accordion_page.dart';
import 'action_sheet_page.dart';
import 'badge_page.dart';
import 'buttons_page.dart';
import 'appbar_page.dart';
import 'cards_page.dart';
import 'cards_expandable_page.dart';
import 'checkbox_page.dart';
import 'chips_page.dart';
import 'contacts_list_page.dart';
import 'content_block_page.dart';
import 'data_table_page.dart';
import 'dialog_page.dart';
import 'fab_page.dart';
import 'fab_morph_page.dart';
import 'form_storage_page.dart';
import 'infinite_scroll_page.dart';
import 'form_inputs_page.dart';
import 'list_view_page.dart';
import 'timeline_page.dart';
import 'tabs_page.dart'; // ✅ Import Tabs Page
import 'treeview_page.dart';
import 'virtual_list_page.dart';
import 'elevation_page.dart';
import 'gauge_page.dart';
import 'grid_layout_page.dart';
import 'icons_page.dart';
import 'lazy_load_page.dart';
import 'list_index_page.dart';
import 'login_screen_page.dart';
import 'menu_page.dart';
import 'navbar_page.dart';
import 'notifications_page.dart';
import 'panel_page.dart';
import 'radio_page.dart';
import 'sortable_list_page.dart';
import 'text_editor_page.dart';
import 'toast_page.dart';
import 'tooltip_page.dart';
import 'toggle_page.dart';

// 🚀 TAMBAHAN BARU
import '../../../widgets/custom_drawer.dart';

// Data untuk item-item di bagian Components (Daftar Lengkap)
final List<String> componentItems = [
  'Accordion', 'Action Sheet', 'Appbar', 'Autocomplete', 'Badge', 'Buttons',
  'Calendar / Date Picker', 'Cards', 'Cards Expandable', 'Checkbox',
  'Chips / Tags', 'Color Picker', 'Contacts List', 'Content Block',
  'Data Table', 'Dialog', 'Elevation', 'FAB', 'FAB Morph', 'Form Storage',
  'Gauge', 'Grid / Layout Grid', 'Icons', 'Infinite Scroll',
  'Inputs', 'Lazy Load', 'List View', 'List Index', 'Login Screen', 'Menu',
  'Messages', 'Navbar', 'Notifications', 'Panel / Side Panels',
  'Photo Browser', 'Picker', 'Popover', 'Popup', 'Preloader',
  'Progress Bar', 'Radio', 'Range Slider', 'Searchbar',
  'Searchbar Expandable', 'Sheet Modal', 'Skeleton (Ghost) Layouts',
  'Smart Select', 'Sortable List', 'Stepper', 'Subnavbar',
  'Swipeout (Swipe To Delete)',
  'Swipe Slider',
  'Tabs',
  'Text Editor', // ✅ Item Target
  'Timeline', 'Toast', 'Toggle', 'Toolbar & Tabbar', 'Tooltip',
  'Treeview', 'Virtual List', 'VI- Mobile Vidio SSP',
];

class Framework7HomePage extends StatelessWidget {
  const Framework7HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 🚀 AMBIL DATA TEMA DINAMIS
    final theme = Theme.of(context);
    final kPrimaryColor = theme.primaryColor;
    final kScaffoldBackground = theme.scaffoldBackgroundColor;
    final kCardColor = theme.cardColor;

    // Penentuan warna adaptif
    final isDark = theme.brightness == Brightness.dark;
    final kTextColor = theme.textTheme.bodyMedium?.color ??
        (isDark ? Colors.white70 : Colors.black87);
    final kHeaderColor = theme.textTheme.titleLarge?.color ??
        (isDark ? Colors.white : Colors.black87);

    // Warna latar belakang yang sebelumnya statis (lightPurpleBackground, iconBackground)
    final kLightBackground = isDark
        ? kCardColor
        : Color.lerp(Colors.white, kPrimaryColor, 0.08) ?? Colors.white;
    final kIconBackground = isDark ? kCardColor : Colors.grey.shade100;
    final kBlockBorderColor =
        isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return Scaffold(
      backgroundColor: kScaffoldBackground,
      // 🚀 TAMBAHAN BARU: Menambahkan drawer ke Scaffold
      drawer: Drawer(child: CustomDrawerBody()),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: kScaffoldBackground, // Gunakan scaffold background
            border: Border(
              bottom: BorderSide(color: kBlockBorderColor, width: 1.0),
            ),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: kTextColor,

            // 🚀 PERBAIKAN: Dibungkus dengan Builder agar dapat 'context'
            // yang benar untuk membuka drawer
            leading: Builder(builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, size: 28, color: kTextColor),
                onPressed: () {
                  // 🚀 PERBAIKAN: Panggil fungsi openDrawer
                  Scaffold.of(context).openDrawer();
                },
              );
            }),

            title: Text(
              'Framework7',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: kTextColor),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.search, size: 28, color: kTextColor),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Framework7',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: kHeaderColor,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- Item "About Framework7" ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildListItem(
                context,
                icon: Icons.work_outline,
                title: 'About Framework7',
                iconColor: kPrimaryColor,
                backgroundColor: kLightBackground, // Latar belakang primer
                isPrimaryButton: true,
                isCustomVI: false,
                textColor: kTextColor,
                blockBorderColor: kBlockBorderColor,
              ),
            ),

            const SizedBox(height: 24),

            // --- Judul "Components" ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Components',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor, // Judul menggunakan warna primer
                ),
              ),
            ),
            const SizedBox(height: 4),

            // --- Daftar Komponen ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: kCardColor, // Kontainer utama menggunakan warna Card
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: kBlockBorderColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: componentItems.map((title) {
                    bool isVIItem = title == 'VI- Mobile Vidio SSP';
                    return _buildListItem(
                      context,
                      icon:
                          isVIItem ? Icons.close : Icons.shopping_bag_outlined,
                      title: title,
                      iconColor: kPrimaryColor,
                      backgroundColor: kIconBackground, // Warna Icon Background
                      isPrimaryButton: false,
                      isCustomVI: isVIItem,
                      textColor: kTextColor,
                      blockBorderColor: kBlockBorderColor,
                    );
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

  // --- FUNGSI PEMBANTU _buildListItem (Menangani Navigasi) ---
  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color backgroundColor,
    required bool isPrimaryButton,
    required bool isCustomVI,
    required Color textColor, // New
    required Color blockBorderColor, // New
  }) {
    // Diganti dari konstanta statis menjadi variabel dinamis
    final framework7Purple = iconColor;

    Widget iconWidget;

    // Logika Ikon (Struktur Aman)
    if (isCustomVI) {
      iconWidget = Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.yellow[600],
              shape: BoxShape.circle,
              border: Border.all(color: blockBorderColor, width: 1.0),
            ),
            child: Center(
              child: Text(
                'vi',
                style: TextStyle(
                  color: Colors.black, // Tetap hitam agar kontras
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (isPrimaryButton) {
      iconWidget = Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: framework7Purple,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: framework7Purple.withOpacity(0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 16),
            ),
          ),
        ),
      );
    } else {
      iconWidget = Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: framework7Purple,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 14),
          ),
        ),
      );
    }
    // Logika Navigasi
    VoidCallback? onTapFunction;
    Widget? page;

    switch (title) {
      case 'About Framework7':
        page = const AboutPage();
        break;
      case 'Accordion':
        page = const AccordionPage();
        break;
      case 'Action Sheet':
        page = ActionSheetPage();
        break;
      case 'Badge':
        page = const BadgePage();
        break;
      case 'Buttons':
        page = const ButtonsPage();
        break;
      case 'Appbar':
        page = const AppbarPage();
        break;
      case 'Cards':
        page = const CardsPage();
        break;
      case 'Cards Expandable':
        page = const CardsExpandablePage();
        break;
      case 'Checkbox':
        page = const CheckboxPage();
        break;
      case 'Chips / Tags':
        page = ChipsPage();
        break;
      case 'Contacts List':
        page = const ContactListPage();
        break;
      case 'Content Block':
        page = const ContentBlockPage();
        break;
      case 'Data Table':
        page = const DataTablePage();
        break;
      case 'Dialog':
        page = const DialogPage();
        break;
      case 'FAB':
        page = const FabPage();
        break;
      case 'FAB Morph':
        page = const FabMorphPage();
        break;
      case 'Form Storage':
        page = const FormStoragePage();
        break;
      case 'Infinite Scroll':
        page = const InfiniteScrollPage();
        break;
      case 'Inputs':
        page = const FormInputsPage();
        break;
      case 'List View':
        page = const ListViewPage();
        break;
      case 'Timeline':
        page = const TimelinePage();
        break;
      case 'Tabs': // ✅ NAVIGASI TABS
        page = const TabsPage();
        break;
      case 'Treeview':
        page = const TreeviewPage();
        break;
      case 'Virtual List':
        page = const HomePage();
        break;
      case 'Elevation':
        page = const ElevationPage();
        break;
      case 'Gauge':
        page = const GaugePage();
        break;
      case 'Grid / Layout Grid':
        page = const GridLayoutPage();
        break;
      case 'Icons':
        page = const IconsPage();
        break;
      case 'Lazy Load':
        page = const LazyLoadPage();
        break;
      case 'List Index':
        page = const ListIndexPage();
        break;
      case 'Login Screen':
        page = const LoginScreenLayout();
        break;
      case 'Menu':
        page = const MenuPage();
        break;
      case 'Navbar':
        page = const NavbarOptionsPage();
        break;
      case 'Notifications':
        page = const NotificationsPage();
        break;
      case 'Panel / Side Panels':
        page = const PanelPage();
        break;
      case 'Radio':
        page = const RadioPage();
        break;
      case 'Sortable List':
        page = const SortableListPage();
        break;
      case 'Text Editor':
        page = const TextEditorPage();
        break;
      case 'Toast':
        page = const ToastPage();
        break;
      case 'Tooltip':
        page = const TooltipPage();
        break;
      case 'Toggle':
        page = const TogglePage();
        break;
      case 'Calendar / Date Picker':
        onTapFunction = () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Elevation adalah properti desain (shadow/bayangan) dan tidak memiliki halaman terpisah.',
                ),
              ),
            );
        break;
      default:
        onTapFunction = () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Navigasi untuk ${title} belum diimplementasikan.'),
              ),
            );
    }

    if (page != null) {
      onTapFunction = () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
    }

    return InkWell(
      onTap: onTapFunction,
      child: Container(
        decoration: isPrimaryButton
            ? BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
              )
            : null,
        padding: isPrimaryButton
            ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0)
            : const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            iconWidget,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}
