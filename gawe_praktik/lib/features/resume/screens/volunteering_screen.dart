import 'package:flutter/material.dart';

// Menggunakan StatefulWidget agar nilai Dropdown Bulan dan Tahun bisa diubah
class VolunteeringScreen extends StatefulWidget {
  const VolunteeringScreen({super.key});

  @override
  State<VolunteeringScreen> createState() => _VolunteeringScreenState();
}

class _VolunteeringScreenState extends State<VolunteeringScreen> {
  // Data dummy untuk Dropdown Bulan dan Tahun
  final List<String> _months = const [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<String> _years = const ['2025', '2024', '2023', '2022', '2021', '2020', '2019', '2018'];

  // State untuk menampung nilai yang dipilih pada Dropdown
  String _selectedStartMonth = 'January';
  String _selectedStartYear = '2022';
  String _selectedEndMonth = 'January';
  String _selectedEndYear = '2022';

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
                      child: Icon(Icons.volunteer_activism_outlined, // Ikon tangan/hati
                          color: colorPurpleText, size: 40),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Volunteering",
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
              // Title
              _buildFormLabel("Title"),
              _buildTextField("Title"),
              const SizedBox(height: 16),

              // Start Date
              _buildFormLabel("Start"),
              Row(
                children: [
                  Expanded(child: _buildMonthDropdown(context, true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildYearDropdown(context, true)),
                ],
              ),
              const SizedBox(height: 16),

              // End Date
              _buildFormLabel("End"),
              Row(
                children: [
                  Expanded(child: _buildMonthDropdown(context, false)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildYearDropdown(context, false)),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              _buildFormLabel("Description"),
              _buildDescriptionTextField(colorUnguMuda),
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

  Widget _buildDescriptionTextField(Color colorUnguMuda) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
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
  
  // Widget Dropdown Bulan (Stateful)
  Widget _buildMonthDropdown(BuildContext context, bool isStart) {
    String selectedValue = isStart ? _selectedStartMonth : _selectedEndMonth;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[600]),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          items: _months.map((String month) {
            return DropdownMenuItem<String>(
              value: month,
              child: Text(month),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() { // Perbarui state saat nilai berubah
                if (isStart) {
                  _selectedStartMonth = newValue;
                } else {
                  _selectedEndMonth = newValue;
                }
              });
            }
          },
        ),
      ),
    );
  }

  // Widget Dropdown Tahun (Stateful)
  Widget _buildYearDropdown(BuildContext context, bool isStart) {
    String selectedValue = isStart ? _selectedStartYear : _selectedEndYear;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[600]),
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: Theme.of(context).textTheme.bodyLarge?.fontFamily,
          ),
          items: _years.map((String year) {
            return DropdownMenuItem<String>(
              value: year,
              child: Text(year),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() { // Perbarui state saat nilai berubah
                if (isStart) {
                  _selectedStartYear = newValue;
                } else {
                  _selectedEndYear = newValue;
                }
              });
            }
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
          print("Save Volunteering pressed: Start $_selectedStartMonth $_selectedStartYear, End $_selectedEndMonth $_selectedEndYear");
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