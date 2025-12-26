import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
const Color listSeparatorColor = Color(0xFFD9D9D9);

// Data untuk Radio Group
final List<String> groupOptions = ['Books', 'Movies', 'Food', 'Drinks'];

// Data untuk Media List
final List<Map<String, dynamic>> mediaListItems = [
  {
    'title': 'Facebook',
    'subtitle':
        'New messages from John Doe\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis...',
    'time': '17:14',
    'id': 'msg_1',
  },
  {
    'title': 'John Doe (via Twitter)',
    'subtitle':
        'John Doe (@_johndoe) mentioned you on Twitter!\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis...',
    'time': '17:11',
    'id': 'msg_2',
  },
  {
    'title': 'Facebook',
    'subtitle':
        'New messages from John Doe\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis...',
    'time': '16:48',
    'id': 'msg_3',
  },
  {
    'title': 'John Doe (via Twitter)',
    'subtitle':
        'John Doe (@_johndoe) mentioned you on Twitter!\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sagittis tellus ut turpis...',
    'time': '15:32',
    'id': 'msg_4',
  },
];

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  // State untuk Radio Group 1 (Inline)
  // 🚀 PERBAIKAN: Hapus _inlineValue karena tidak terpakai
  // String? _inlineValue = 'radio_1';
  String? _inlineSelected = 'radio_1'; // Untuk radio yang dipilih

  // State untuk Radio Group 2 (Kiri)
  String? _groupLeftSelected = 'Food';

  // State untuk Radio Group 3 (Kanan)
  String? _groupRightSelected = 'Books';

  // State untuk Media List
  String? _mediaListSelected = 'msg_1';

  // --- Widget Pembantu: Judul Bagian Ungu ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: framework7Purple,
        ),
      ),
    );
  }

  // --- Widget Pembantu: Radio Kustom Kompak (untuk Inline) ---
  Widget _buildInlineRadio({
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Transform.scale(
      scale: 0.9,
      child: Radio<String>(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: framework7Purple,
      ),
    );
  }

  // --- Widget Pembantu: Item Radio Group Sederhana ---
  Widget _buildSimpleRadioItem({
    required String label,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
    required bool radioOnLeft,
  }) {
    // Radio Group (Radio di Kiri)
    if (radioOnLeft) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: framework7Purple,
        ),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        onTap: () => onChanged(value),
      );
    }
    // Radio Group (Radio di Kanan)
    else {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        trailing: Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: framework7Purple,
        ),
        onTap: () => onChanged(value),
      );
    }
  }

  // --- Widget Pembantu: Item Radio Media List ---
  Widget _buildMediaRadioItem(Map<String, dynamic> item) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Radio<String>(
            value: item['id'],
            groupValue: _mediaListSelected,
            onChanged: (newValue) {
              setState(() {
                _mediaListSelected = newValue;
              });
            },
            activeColor: framework7Purple,
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  item['time'],
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
          subtitle: Text(
            item['subtitle'],
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            setState(() {
              _mediaListSelected = item['id'];
            });
          },
        ),
        const Divider(height: 1, thickness: 0.5, color: listSeparatorColor),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar (Header Halaman) ---
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightPurpleBackground,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Radio',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ----------------------------------------------------
            // 1. Inline Radio (Gambar 1)
            // ----------------------------------------------------
            _buildSectionTitle('Inline'),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                  children: [
                    const TextSpan(text: 'Lorem '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: _buildInlineRadio(
                        value: 'radio_1',
                        groupValue: _inlineSelected,
                        onChanged: (newValue) {
                          setState(() {
                            _inlineSelected = newValue;
                          });
                        },
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' ipsum dolor sit amet, consectetur adipisicing elit. Alias beatae illo nihil aut eius commodi sint eveniet aliquid eligendi',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: _buildInlineRadio(
                        value: 'radio_2',
                        groupValue: _inlineSelected,
                        onChanged: (newValue) {
                          setState(() {
                            _inlineSelected = newValue;
                          });
                        },
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' ad delectus impedit tempore nemo, enim vel praesentium consequatur nulla mollitia!',
                    ),
                  ],
                ),
              ),
            ),

            // ----------------------------------------------------
            // 2. Radio Group (Radio di Kiri) (Gambar 1 & 2)
            // ----------------------------------------------------
            _buildSectionTitle('Radio Group'),
            Column(
              children: groupOptions.map((option) {
                return _buildSimpleRadioItem(
                  label: option,
                  value: option,
                  groupValue: _groupLeftSelected,
                  onChanged: (newValue) {
                    setState(() {
                      _groupLeftSelected = newValue;
                    });
                  },
                  radioOnLeft: true,
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // ----------------------------------------------------
            // 3. Radio Group (Radio di Kanan) (Gambar 1 & 2)
            // ----------------------------------------------------
            _buildSectionTitle('Radio Group'),
            Column(
              children: groupOptions.map((option) {
                return _buildSimpleRadioItem(
                  label: option,
                  value: option,
                  groupValue: _groupRightSelected,
                  onChanged: (newValue) {
                    setState(() {
                      _groupRightSelected = newValue;
                    });
                  },
                  radioOnLeft: false,
                );
              }).toList(),
            ),

            // ----------------------------------------------------
            // 4. With Media Lists (Gambar 1 & 2)
            // ----------------------------------------------------
            _buildSectionTitle('With Media Lists'),
            Column(
              children: mediaListItems.map((item) {
                return _buildMediaRadioItem(item);
              }).toList(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
