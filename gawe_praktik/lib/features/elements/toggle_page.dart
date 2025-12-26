import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);

// Data Model untuk setiap pahlawan
class HeroToggle {
  final String name;
  final Color activeColor;
  bool isEnabled;

  HeroToggle({
    required this.name,
    required this.activeColor,
    this.isEnabled = false,
  });
}

// Data daftar pahlawan dengan warna kustom
final List<HeroToggle> heroData = [
  // Gambar 1: Batman (Ungu Tua)
  HeroToggle(
    name: 'Batman',
    activeColor: const Color(0xFF673AB7),
    isEnabled: true,
  ),
  // Gambar 1: Aquaman (Biru Cerah)
  HeroToggle(
    name: 'Aquaman',
    activeColor: const Color(0xFF03A9F4),
    isEnabled: true,
  ),
  // Gambar 1: Superman (Merah Cerah)
  HeroToggle(
    name: 'Superman',
    activeColor: const Color(0xFFF44336),
    isEnabled: true,
  ),
  // Gambar 1: Hulk (Hijau Tua)
  HeroToggle(
    name: 'Hulk',
    activeColor: const Color(0xFF4CAF50),
    isEnabled: true,
  ),
  // Gambar 1: Spiderman (Ungu Muda)
  HeroToggle(
    name: 'Spiderman',
    activeColor: const Color(0xFF9C27B0),
    isEnabled: true,
  ),
  // Gambar 1: Ironman (Ungu Magenta)
  HeroToggle(
    name: 'Ironman',
    activeColor: const Color(0xFF9147FF),
    isEnabled: true,
  ),
  // Gambar 1: Thor (Cokelat Tua)
  HeroToggle(
    name: 'Thor',
    activeColor: const Color(0xFF795548),
    isEnabled: true,
  ),
  // Gambar 1: Wonder (Merah Muda/Salem)
  HeroToggle(
    name: 'Wonder',
    activeColor: const Color(0xFFFF9800).withOpacity(0.8),
    isEnabled: true,
  ),
];

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  // Menggunakan list data hero sebagai state
  late List<HeroToggle> _heroes;

  @override
  void initState() {
    super.initState();
    // Menggunakan data dummy yang sudah diatur (semua aktif di awal)
    _heroes = List.from(heroData);

    // Untuk meniru Gambar 2 (kondisi setelah di klik/geser), kita bisa menyetel
    // beberapa nilai awal menjadi false, atau membiarkannya default dan user yang geser.
    // Kita akan biarkan default, dan user bisa menggeser sesuai keinginan.
  }

  void _onToggleChanged(int index, bool newValue) {
    setState(() {
      _heroes[index].isEnabled = newValue;
    });
  }

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

  // --- Widget Pembantu: List Item dengan Toggle Kustom ---
  Widget _buildToggleListItem(int index, HeroToggle hero) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          title: Text(
            hero.name,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          trailing: Switch(
            value: hero.isEnabled,
            onChanged: (newValue) => _onToggleChanged(index, newValue),

            // Warna ON: Warna kustom pahlawan
            activeColor: hero.activeColor,
            // Warna OFF (track/latar belakang):
            inactiveThumbColor:
                Colors.grey.shade400, // Lingkaran abu-abu saat OFF
            inactiveTrackColor:
                Colors.grey.shade200, // Latar belakang abu-abu saat OFF
          ),
          onTap: () {
            // Memungkinkan toggle berubah saat ListTile diklik juga
            _onToggleChanged(index, !hero.isEnabled);
          },
        ),
        // Divider untuk memisahkan setiap item
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Divider(height: 1, thickness: 0.5, color: dividerColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            color: lightPurpleBackground,
            border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Toggle',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Judul Bagian
            _buildSectionTitle('Super Heroes'),

            // Daftar Toggle
            ..._heroes.asMap().entries.map((entry) {
              return _buildToggleListItem(entry.key, entry.value);
            }).toList(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
