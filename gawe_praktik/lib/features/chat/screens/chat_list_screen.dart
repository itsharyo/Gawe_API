import 'package:flutter/material.dart';
import '../data/dummy_data.dart'; // Import messagesData
import '../widgets/message_list_item.dart'; // Import MessageListItem

// Asumsi: Import CustomDrawerBody. Sesuaikan path ini jika berbeda.
import '../../../widgets/custom_drawer.dart';

// ====================================================================
// B. LAYAR DAFTAR PESAN (ChatListScreen)
// ====================================================================

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Tambahkan Drawer di sisi kiri
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        actions: [
          // 2. Gunakan Builder dan IconButton untuk membuka Drawer
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                padding: const EdgeInsets.only(right: 8.0),
                onPressed: () {
                  // Membuka Drawer dari kiri
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar (Ikon di Kanan)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // Menggunakan warna tema
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                style: TextStyle(fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  hintText: 'Search job here...',
                  suffixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20.0,
                  ),
                ),
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: ListView.builder(
              itemCount: messagesData.length,
              itemBuilder: (context, index) {
                return MessageListItem(item: messagesData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
