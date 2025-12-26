import 'package:flutter/material.dart';

// Definisi data kontak yang akan ditampilkan
// Struktur: { "Indeks Huruf": [ "Daftar Nama Kontak" ] }
final Map<String, List<String>> contactsData = {
  'A': [
    'Aaron',
    'Abbie',
    'Adam',
    'Adele',
    'Agatha',
    'Agnes',
    'Albert',
    'Alexander',
  ],
  'B': ['Bailey', 'Barclay', 'Bartolo', 'Bellamy', 'Belle', 'Benjamin'],
  'C': ['Caiden', 'Calvin', 'Candy', 'Carl', 'Cherilyn', 'Chester', 'Chloe'],
  'V': ['Vladimir'],
  // Anda bisa menambahkan kontak lain di sini
};

// Mengubah Map menjadi List of items untuk ListView
// Setiap item bisa berupa Header (indeks huruf) atau Contact (nama)
List<dynamic> getFlattenedContacts() {
  List<dynamic> flattenedList = [];
  contactsData.forEach((key, value) {
    // Tambahkan header huruf
    flattenedList.add(key);
    // Tambahkan semua nama kontak di bawah header tersebut
    flattenedList.addAll(value);
  });
  return flattenedList;
}

class ContactListPage extends StatelessWidget {
  const ContactListPage({super.key});

  final Color framework7Purple = const Color(0xFF9147FF);
  // Definisikan warna pemisah di sini, karena Anda mungkin ingin menambahkannya kembali
  final Color listSeparatorColor = const Color(0xFFE0E0E0);

  @override
  Widget build(BuildContext context) {
    final List<dynamic> contacts = getFlattenedContacts();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contacts List',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final item = contacts[index];

          if (item is String &&
              item.length == 1 &&
              contactsData.containsKey(item)) {
            // Ini adalah Header (Indeks Huruf)
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                16,
                4,
              ), // Disesuaikan sedikit
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: framework7Purple, // Warna ungu untuk indeks
                ),
              ),
            );
          } else {
            // Ini adalah Item Kontak
            return Column(
              children: [
                ListTile(
                  title: Text(
                    item.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Anda mengklik: ${item.toString()}'),
                      ),
                    );
                  },
                ),
                // Tambahkan Divider untuk garis pemisah yang rapi
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Divider(
                    height: 1,
                    thickness: 0.5,
                    color: listSeparatorColor,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
