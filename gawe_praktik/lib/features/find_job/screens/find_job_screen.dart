import 'package:flutter/material.dart';
// Import Custom Drawer Anda. Asumsi: lib/widgets/custom_drawer.dart
import 'package:gawe/widgets/custom_drawer.dart';
// Import ini tidak diperlukan karena kita menggunakan Named Routes
// import '../../widgets/custom_drawer.dart';

class FindJobScreen extends StatelessWidget {
  const FindJobScreen({super.key});

  // Daftar untuk chip "Popular Searches"
  final List<String> popularSearches = const [
    "Software developer fresher",
    "Worker From Home",
    "Driver",
    "HR fresher",
    "Software testing",
    "Sales executive",
    "Business analyst",
    "Receptionist",
    "Data analyst",
    "SEO executive"
  ];

  // Fungsi 'build' utama
  @override
  Widget build(BuildContext context) {
    // --- AMBIL SEMUA WARNA DARI TEMA ---
    final theme = Theme.of(context);
    final Color colorPrimaryButton = theme.primaryColor;
    final Color colorChipBackground = colorPrimaryButton.withOpacity(0.1);

    // Inisialisasi warna dibersihkan total
    final Color colorGreyText =
        theme.textTheme.bodyMedium?.color ?? Colors.grey.shade600;
    final Color colorTitleText =
        theme.textTheme.bodyLarge?.color ?? Colors.black87;
    final Color colorCardBackground = theme.cardColor;
    // ---

    return Scaffold(
      // PERBAIKAN 1: Gunakan 'drawer' (Drawer Kiri)
      drawer: const Drawer(
        child: CustomDrawerBody(),
      ),

      // 1. APP BAR
      appBar: AppBar(
        // Leading default (ikon panah kembali) tetap ada
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Find Job",
        ),
        centerTitle: true,
        // AKSI TITIK TIGA (Membuka Drawer Kiri)
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                // Menggunakan ikon titik tiga, tetapi fungsinya adalah membuka drawer
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // Perintah untuk membuka Drawer KIRI
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      // 2. BODY UTAMA
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3. KOTAK SEARCH INPUT
            _buildSearchBox(colorCardBackground, colorTitleText, colorGreyText),
            const SizedBox(height: 24),

            // 4. TOMBOL SEARCH
            _buildSearchButton(context, colorPrimaryButton),
            const SizedBox(height: 32),

            // 5. JUDUL "POPULAR SEARCHES"
            Text(
              "Popular Searches",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorTitleText,
              ),
            ),
            const SizedBox(height: 16),

            // 6. CHIP "POPULAR SEARCHES"
            _buildPopularSearchChips(
                context, colorChipBackground, colorGreyText),
            const SizedBox(height: 32),

            // 7. TOMBOL "CREATE YOUR RESUME"
            _buildCreateResume(context, colorTitleText),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  Widget _buildSearchBox(
      Color backgroundColor, Color textColor, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Gunakan cardColor
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: textColor), // Warna teks input
            onTap: () => print("Tapped job title field"),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: iconColor),
              hintText: "job title, keywords, or company",
              hintStyle: TextStyle(color: iconColor.withOpacity(0.5)),
              border: InputBorder.none,
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade200,
            indent: 20,
            endIndent: 20,
          ),
          TextField(
            style: TextStyle(color: textColor),
            onTap: () => print("Tapped city field"),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.location_on_outlined, color: iconColor),
              hintText: "Enter city or locality",
              hintStyle: TextStyle(color: iconColor.withOpacity(0.5)),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context, Color colorPrimaryButton) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print("Search pressed, navigating to /company_list");
          // Gunakan Rute Bernama
          Navigator.pushNamed(context, '/company_list');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "SEARCH",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopularSearchChips(
      BuildContext context, Color colorChipBackground, Color colorGreyText) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: popularSearches.map((text) {
        return Material(
          color: colorChipBackground, // Gunakan warna tema adaptif
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            onTap: () {
              print("Chip pressed: $text, navigating to /company_list");
              // Gunakan Rute Bernama
              Navigator.pushNamed(context, '/company_list');
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 18, color: colorGreyText),
                  const SizedBox(width: 6),
                  Text(text, style: TextStyle(color: colorGreyText)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCreateResume(BuildContext context, Color colorTitleText) {
    return InkWell(
      onTap: () {
        print("Create Your Resume pressed, navigating to /resume");
        // Gunakan Rute Bernama
        Navigator.pushNamed(context, '/resume');
      },
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Create Your Resume",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorTitleText,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: colorTitleText,
            ),
          ],
        ),
      ),
    );
  }
}
