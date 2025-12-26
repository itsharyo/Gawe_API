import 'package:flutter/material.dart';

// Kita gunakan StatefulWidget agar Dropdown Bulan dan Tahun bisa diganti-ganti nilainya
class AwardsScreen extends StatefulWidget {
  const AwardsScreen({super.key});

  @override
  State<AwardsScreen> createState() => _AwardsScreenState();
}

class _AwardsScreenState extends State<AwardsScreen> {
  // Data dummy untuk Dropdown Bulan dan Tahun
  final List<String> _months = const [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> _years = const ['2025', '2024', '2023', '2022', '2021', '2020', '2019', '2018'];

  // State untuk menampung nilai yang dipilih pada Dropdown
  String _selectedMonth = 'July';
  String _selectedYear = '2022';

  @override
  Widget build(BuildContext context) {
    // --- AMBIL SEMUA WARNA DARI TEMA (Sangat Rapi) ---
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final Color colorPrimary = colorScheme.primary;
    final Color colorText = colorScheme.onBackground; // Warna teks utama, adaptif (Putih di Dark Mode)
    final Color colorSubtitle = colorScheme.onSurfaceVariant; // Warna teks sekunder (Abu-abu adaptif)
    final Color colorCardBackground = theme.cardColor; // Latar belakang input/card
    final Color colorScaffoldBackground = colorScheme.background; // Latar belakang utama BottomSheet
    
    // Warna Netral
    final Color colorBorder = colorScheme.outline; // Menggunakan warna outline dari ColorScheme
    // ---

    // Kita return Container sebagai konten Bottom Sheet
    return Container(
      // Menggunakan warna background scaffold tema
      color: colorScaffoldBackground, 
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
              // Title
              _buildFormLabel("Title", colorText),
              _buildTextField(
                hintText: "Title", 
                backgroundColor: colorCardBackground, 
                borderColor: colorBorder, 
                textColor: colorText,
                hintColor: colorSubtitle,
              ),
              const SizedBox(height: 16),

              // Start Date
              _buildFormLabel("Start", colorText),
              Row(
                children: [
                  // Dropdown Bulan (Stateful)
                  Expanded(
                    child: _buildMonthDropdown(
                      context, 
                      colorCardBackground, 
                      colorBorder, 
                      colorSubtitle, 
                      colorText
                    )
                  ),
                  const SizedBox(width: 16),
                  // Dropdown Tahun (Stateful)
                  Expanded(
                    child: _buildYearDropdown(
                      context, 
                      colorCardBackground, 
                      colorBorder, 
                      colorSubtitle, 
                      colorText
                    )
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              _buildFormLabel("Description", colorText),
              _buildDescriptionTextField(
                backgroundColor: colorCardBackground, 
                borderColor: colorBorder, 
                textColor: colorText,
                hintColor: colorSubtitle,
              ),
              const SizedBox(height: 32),

              // 4. TOMBOL-TOMBOL (Dibalik: Save yang utama)
              _buildSaveButton(colorPrimary, colorText),
              const SizedBox(height: 12),
              _buildCancelButton(context, colorPrimary), // Cancel kini OutlinedButton
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
              // Latar belakang ikon: Gunakan warna tema dengan opasitas rendah
              color: colorPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: Icon(Icons.military_tech_outlined, 
                color: colorPrimary, size: 40), // Ikon berwarna primer
          ),
          const SizedBox(height: 16),
          Text(
            "Award",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorText, // Gunakan warna teks tema
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
    required Color backgroundColor, 
    required Color borderColor, 
    required Color textColor, 
    required Color hintColor
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        style: TextStyle(color: textColor), // Warna teks input
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

  Widget _buildDescriptionTextField({
    required Color backgroundColor, 
    required Color borderColor, 
    required Color textColor, 
    required Color hintColor
  }) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        style: TextStyle(color: textColor),
        keyboardType: TextInputType.multiline,
        minLines: 8,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Description",
          hintStyle: TextStyle(color: hintColor.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
  
  // Widget Dropdown Bulan (Stateful)
  Widget _buildMonthDropdown(BuildContext context, Color backgroundColor, Color borderColor, Color iconColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedMonth, 
          isExpanded: true,
          // Menggunakan warna teks utama untuk ikon
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: textColor), 
          style: TextStyle(
            color: textColor, // Warna teks di dalam Dropdown
            fontSize: 16,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          dropdownColor: backgroundColor, // Warna latar belakang item dropdown
          items: _months.map((String month) {
            return DropdownMenuItem<String>(
              value: month,
              child: Text(month),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() { 
                _selectedMonth = newValue;
              });
            }
          },
        ),
      ),
    );
  }

  // Widget Dropdown Tahun (Stateful)
  Widget _buildYearDropdown(BuildContext context, Color backgroundColor, Color borderColor, Color iconColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedYear, 
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: textColor),
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          dropdownColor: backgroundColor,
          items: _years.map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(year),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() { 
                _selectedYear = newValue;
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
      child: ElevatedButton( // Tombol Save dijadikan Elevated (primer)
        onPressed: () {
          // Tutup Bottom Sheet dan lakukan aksi Save
          Navigator.pop(context, true); 
          print("Save Awards pressed: $_selectedMonth $_selectedYear");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary, // Latar belakang warna primer
          foregroundColor: Colors.white, // Teks selalu putih/kontras
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
      // Tombol Cancel dijadikan OutlinedButton (sekunder)
      child: OutlinedButton( 
        onPressed: () {
          Navigator.pop(context); // Tutup Bottom Sheet
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: colorPrimary, // Teks berwarna primer
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