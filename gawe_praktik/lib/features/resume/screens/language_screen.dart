import 'package:flutter/material.dart';

// Diubah menjadi StatefulWidget untuk mengelola Dropdown Level dan Input Bahasa
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  // Data dummy untuk Dropdown Level Kemahiran
  final List<String> _levels = const [
    'basic', 'conversational', 'fluent', 'native'
  ];

  // State untuk menampung nilai yang dipilih pada Dropdown dan TextField
  String _selectedLevel = 'basic';
  // Jika ini adalah form 'Add Language', kita bisa biarkan TextField kosong
  final TextEditingController _languageController = TextEditingController(); 

  @override
  void dispose() {
    _languageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- AMBIL SEMUA WARNA DARI TEMA (Adaptif) ---
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final Color colorPrimary = colorScheme.primary;
    final Color colorScaffoldBackground = colorScheme.background; // Latar belakang utama BottomSheet
    final Color colorCardBackground = theme.cardColor; // Latar belakang Input/Dropdown
    final Color colorText = colorScheme.onBackground; // Warna teks utama
    final Color colorSubtitle = colorScheme.onSurfaceVariant; // Warna teks sekunder/hint
    
    // Warna Netral
    final Color colorBorder = colorScheme.outline;
    // ---

    // Kita return Container sebagai konten Bottom Sheet
    return Container(
      color: colorScaffoldBackground, // Menggunakan warna background scaffold tema
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HANDLE (garis abu-abu di atas)
              _buildHandle(colorBorder),
              const SizedBox(height: 24),

              // 2. HEADER (IKON DAN JUDUL)
              _buildHeader(colorPrimary, colorText),
              const SizedBox(height: 32),

              // 3. FORM INPUTS
              // Language Input
              _buildFormLabel("Language", colorText), // Typo 'Langauage' diperbaiki
              _buildTextField(
                hintText: "Language", 
                controller: _languageController,
                backgroundColor: colorCardBackground, 
                borderColor: colorBorder, 
                textColor: colorText,
                hintColor: colorSubtitle,
              ),
              const SizedBox(height: 16),

              // Level Dropdown
              _buildFormLabel("Level", colorText),
              _buildLevelDropdown(
                context, 
                colorCardBackground, 
                colorBorder, 
                colorSubtitle, 
                colorText
              ),
              const SizedBox(height: 32),

              // 4. TOMBOL-TOMBOL (Save: Elevated Button Utama, Cancel: Outlined Button Sekunder)
              _buildSaveButton(colorPrimary, colorText),
              const SizedBox(height: 12),
              _buildCancelButton(context, colorPrimary),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // --- WIDGET BANTUAN (ADAPTIF TEMA) ---
  // -------------------------------------------------------------------

  Widget _buildHandle(Color colorBorder) {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: colorBorder,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildHeader(Color colorPrimary, Color colorText) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              // Latar belakang ikon adaptif
              color: colorPrimary.withOpacity(0.1), 
              borderRadius: BorderRadius.circular(50.0),
              // Hapus border Colors.grey[200] karena tidak adaptif
            ),
            // Ikon google translate (g_translate)
            child: Icon(Icons.g_translate_outlined, 
                color: colorPrimary, size: 40), // Ikon berwarna primer
          ),
          const SizedBox(height: 16),
          Text(
            "Language", // Typo 'Langauage' diperbaiki
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorPrimary, // Judul menggunakan warna Primer
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormLabel(String label, Color colorText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          color: colorText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText, 
    required TextEditingController controller,
    required Color backgroundColor, 
    required Color borderColor, 
    required Color textColor, 
    required Color hintColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Latar belakang Input: CardColor
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: textColor), // Warna teks input adaptif
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }

  // Widget Dropdown Level Kemahiran (Stateful)
  Widget _buildLevelDropdown(
    BuildContext context, 
    Color backgroundColor, 
    Color borderColor, 
    Color iconColor, 
    Color textColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedLevel, 
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: iconColor),
          style: TextStyle(
            color: textColor, // Warna teks di dalam Dropdown adaptif
            fontSize: 16,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          dropdownColor: backgroundColor,
          items: _levels.map((String level) {
            return DropdownMenuItem<String>(
              value: level,
              child: Text(level),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedLevel = newValue; // Perbarui state
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton(Color colorPrimary, Color colorText) {
    return SizedBox(
      width: double.infinity,
      // Save dijadikan Elevated Button (Primary)
      child: ElevatedButton(
        onPressed: () {
          // Tutup bottom sheet dan kirim data yang disimpan (misal: bahasa dan level)
          Navigator.pop(context, {'language': _languageController.text, 'level': _selectedLevel});
          print("Save Language pressed: ${_languageController.text}, Level: $_selectedLevel");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Save",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, Color colorPrimary) {
    return SizedBox(
      width: double.infinity,
      // Cancel dijadikan Outlined Button (Secondary)
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context); // Tutup Bottom Sheet
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: colorPrimary,
          side: BorderSide(color: colorPrimary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          "Cancel",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}