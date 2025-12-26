import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  // Data dummy untuk Dropdown Experience (Tahun Pengalaman) yang diperbarui
  final List<String> _experiences = const [
    '0.5 year', '1 year', '2 year', '3 year', '4 year', '5 year', 
    '6 year', '7 year', '8 year', '9 year', '10 year', '11 year', '12 year', 
    '13 year', '14 year', '15+ year' // Tambahkan lebih banyak untuk scrolling
  ];

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final Color colorPrimaryButton = const Color(0xFF8D3CFF);
    final Color colorPurpleText = const Color(0xFF6A26C4);
    final Color colorIconBackground = const Color(0xFFEDE7F9);
    final Color colorUnguMuda = const Color(0xFFF7F4FD);
    
    // Default value untuk Dropdown
    const String defaultExperience = '2 year'; 

    // Kita return Container sebagai konten Bottom Sheet
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle (garis abu-abu di atas)
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. HEADER (IKON DAN JUDUL)
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: colorIconBackground,
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: Icon(Icons.star_outline, // Ikon bintang
                          color: colorPurpleText, size: 40),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Skills",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 3. FORM INPUTS
              // Your skill
              _buildFormLabel("Your skill"),
              _buildTextField("Your skill"),
              const SizedBox(height: 16),

              // Experience Dropdown
              _buildFormLabel("Experience"),
              _buildExperienceDropdown(context, defaultExperience), // Menggunakan default value
              const SizedBox(height: 32),

              // 4. TOMBOL-TOMBOL
              _buildSaveButton(colorPrimaryButton, colorUnguMuda),
              const SizedBox(height: 12),
              _buildCancelButton(context, colorPrimaryButton),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET BANTUAN ---

  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }

  // Widget Dropdown Experience
  Widget _buildExperienceDropdown(BuildContext context, String selectedValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          // Pastikan nilai default ada di daftar items
          value: selectedValue, 
          isExpanded: true,
          // Menggunakan DropdownButton agar item dapat di-scroll secara otomatis jika daftarnya panjang
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[600]),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          items: _experiences.map((String exp) {
            return DropdownMenuItem<String>(
              value: exp,
              child: Text(exp),
            );
          }).toList(),
          onChanged: (String? newValue) {
            print("Experience changed to $newValue");
            // Catatan: Karena ini StatelessWidget, perubahan nyata memerlukan StatefulWidget
          },
        ),
      ),
    );
  }

  Widget _buildSaveButton(Color colorPrimaryButton, Color colorUnguMuda) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          print("Save Skills pressed");
        },
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
        style: OutlinedButton.styleFrom(
          foregroundColor: colorPrimaryButton,
          backgroundColor: colorUnguMuda,
          side: BorderSide(color: colorPrimaryButton, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, Color colorPrimaryButton) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          print("Cancel pressed");
          Navigator.pop(context); // Tutup Bottom Sheet
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}