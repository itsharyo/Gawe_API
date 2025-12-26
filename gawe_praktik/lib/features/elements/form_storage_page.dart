import 'package:flutter/material.dart';

class FormStoragePage extends StatefulWidget {
  const FormStoragePage({super.key});

  @override
  State<FormStoragePage> createState() => _FormStoragePageState();
}

class _FormStoragePageState extends State<FormStoragePage> {
  final Color framework7Purple = const Color(0xFF9147FF);
  final Color formFieldBackground = Colors.grey.shade100;
  final Color formSeparatorColor = Colors.grey.shade300;
  double _currentRangeValue = 50;
  String? _selectedGender;

  // ✅ INISIALISASI CONTROLLER DENGAN WAKTU BARU: 02:15
  TextEditingController dateTimeController = TextEditingController(
    text: '28/08/2025 02:15',
  );
  TextEditingController birthdayController = TextEditingController(
    text: '28/01/2014',
  );

  @override
  void dispose() {
    dateTimeController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Storage',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Deskripsi Teks
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'With forms storage it is easy to store and parse form data, especially on Ajax loaded pages. All you need to make it work is to add "form-store-data" class to your <form> and Framework7 will store form data with every input change. And the most awesome part is that when you load this page again Framework7 will parse this data and fill all form fields automatically!',
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Just try to fill the form below and then go to any other page, or even you may close this site, and when you return here form fields will have kept your data.',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            // --- Bagian Form (Grup Input) ---
            Column(
              children: [
                _buildFormItem('Name', hintText: 'Your name'),
                const SizedBox(height: 8),

                _buildFormItem(
                  'Password',
                  hintText: 'Your password',
                  obscureText: true,
                ),
                const SizedBox(height: 8),

                _buildFormItem(
                  'E-mail',
                  hintText: 'Your e-mail',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),

                _buildFormItem(
                  'URL',
                  hintText: 'URL',
                  keyboardType: TextInputType.url,
                ),
                const SizedBox(height: 8),

                _buildFormItem(
                  'Phone',
                  hintText: 'Your phone number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 8),

                _buildDropdownItem(
                  'Gender',
                  items: ['Male', 'Female', 'Other'],
                  value: _selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                ),
                const SizedBox(height: 8),

                // 7. Birthday (Date Picker)
                _buildFormItem(
                  'Birthday',
                  controller: birthdayController,
                  readOnly: true,
                  suffixIcon: Icons.calendar_today,
                  onTap: () => _selectDate(context, birthdayController),
                ),
                const SizedBox(height: 8),

                // 8. Date Time
                _buildFormItem(
                  'Date time',
                  controller: dateTimeController,
                  readOnly: true,
                  suffixIcon: Icons.calendar_today,
                  onTap: () => _selectDateAndTime(context), // FUNGSI INI DIUBAH
                ),
                const SizedBox(height: 8),

                // 9. Range
                _buildRangeItem(),
                const SizedBox(height: 8),

                // 10. About you (Multi-line text)
                _buildFormItem(
                  'About you',
                  hintText: 'haha',
                  maxLines: 4,
                  minLines: 1,
                  keyboardType: TextInputType.multiline,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // --- FUNGSI DATE/TIME PICKER ---
  // -------------------------------------------------------------------

  // Fungsi untuk memilih Tanggal saja
  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.tryParse(
            controller.text.split(' ')[0].split('/').reversed.join('-'),
          ) ??
          DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: framework7Purple),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  // ✅ Fungsi untuk memilih Tanggal dan Waktu (diperbarui ke 02:15)
  Future<void> _selectDateAndTime(BuildContext context) async {
    // Nilai awal dari foto: 28 Agustus 2025, 02:15
    DateTime initialDateTime = DateTime(2025, 8, 28, 2, 15);

    // Tampilkan date picker
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime, // ✅ Initial Date: 28/08/2025
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: framework7Purple),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Tampilkan time picker
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: initialDateTime.hour,
          minute: initialDateTime.minute,
        ), // ✅ Initial Time: 02:15
      );

      if (pickedTime != null) {
        // Gabungkan dan format hasil sesuai format 'dd/mm/yyyy hh:mm'
        String dateString =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
        String timeString =
            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";

        setState(() {
          dateTimeController.text = "$dateString $timeString";
        });
      }
    }
  }

  // -------------------------------------------------------------------
  // --- WIDGET PEMBANTU ---
  // -------------------------------------------------------------------

  Widget _buildFormItem(
    String label, {
    String? hintText,
    String? initialValue,
    TextEditingController? controller,
    bool obscureText = false,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? suffixIcon,
    int? maxLines = 1,
    int? minLines,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: formFieldBackground,
        border: Border(
          bottom: BorderSide(color: formSeparatorColor, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        initialValue: controller == null ? initialValue : null,
        controller: controller,
        obscureText: obscureText,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: minLines,
        onTap: onTap,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          fillColor: formFieldBackground,
          filled: true,

          border: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.grey.shade600)
              : null,
        ),
      ),
    );
  }

  Widget _buildDropdownItem(
    String label, {
    required List<String> items,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: formFieldBackground,
        border: Border(
          bottom: BorderSide(color: formSeparatorColor, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          fillColor: formFieldBackground,
          filled: true,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 0,
          ),
        ),
        value: value,
        hint: Text(
          'Select $label',
          style: TextStyle(color: Colors.grey.shade500),
        ),
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRangeItem() {
    return Container(
      decoration: BoxDecoration(
        color: formFieldBackground,
        border: Border(
          bottom: BorderSide(color: formSeparatorColor, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Range',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Slider(
            value: _currentRangeValue,
            min: 0,
            max: 100,
            divisions: 100,
            label: _currentRangeValue.round().toString(),
            activeColor: framework7Purple,
            inactiveColor: Colors.grey.shade300,
            onChanged: (double value) {
              setState(() {
                _currentRangeValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
