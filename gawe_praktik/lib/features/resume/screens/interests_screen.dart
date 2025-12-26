import 'package:flutter/material.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final Color colorPrimaryButton = const Color(0xFF8D3CFF);
    final Color colorPurpleText = const Color(0xFF6A26C4);
    final Color colorIconBackground = const Color(0xFFEDE7F9);
    final Color colorUnguMuda = const Color(0xFFF7F4FD);

    // Kita return Container sebagai konten Bottom Sheet
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: SafeArea( // Tambahkan SafeArea
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Agar tinggi konten pas
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
                      // Ikon untuk Interests (menggunakan Icons.interests_outlined yang serupa)
                      child: Icon(Icons.interests_outlined, 
                          color: colorPurpleText, size: 40),
                    ),
                    const SizedBox(height: 16),
                    // Perhatikan: Judul di desain tertulis "Personal statement", 
                    // tetapi konteksnya adalah "Interests". Saya ikuti ikon dan konteks.
                    const Text(
                      "Personal Statement", 
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

              // 3. LABEL DESKRIPSI
              const Text(
                "Description",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              // 4. TEXT AREA INPUT
              _buildDescriptionTextField(colorUnguMuda),
              const SizedBox(height: 32),

              // 5. TOMBOL-TOMBOL
              // Tombol "Save" (Outlined/Faded)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    print("Save Interests pressed");
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
              ),
              const SizedBox(height: 12),

              // Tombol "Cancel" (Elevated)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("Cancel pressed");
                    Navigator.pop(context); // Menutup Bottom Sheet
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Bantuan untuk Text Area Input
  Widget _buildDescriptionTextField(Color colorUnguMuda) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: const TextField(
        keyboardType: TextInputType.multiline,
        minLines: 8,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Description",
          hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
}