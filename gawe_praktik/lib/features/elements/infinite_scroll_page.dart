import 'package:flutter/material.dart';

class InfiniteScrollPage extends StatefulWidget {
  const InfiniteScrollPage({super.key});

  @override
  State<InfiniteScrollPage> createState() => _InfiniteScrollPageState();
}

class _InfiniteScrollPageState extends State<InfiniteScrollPage> {
  final Color framework7Purple = const Color(0xFF9147FF);
  final ScrollController _scrollController = ScrollController();

  // Batas maksimum item
  final int maxItems = 200;

  // Jumlah item yang saat ini dimuat
  List<String> _items = [];
  int _loadCount = 15; // Jumlah awal item yang dimuat
  bool _isLoading = false; // Status loading untuk mencegah pemuatan ganda
  bool _hasMore = true; // Apakah masih ada item yang perlu dimuat

  @override
  void initState() {
    super.initState();
    // Inisialisasi daftar awal
    _loadInitialData();
    // Menambahkan listener untuk mendeteksi scroll ke bawah
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadInitialData() {
    for (int i = 1; i <= _loadCount; i++) {
      _items.add('Item $i');
    }
  }

  // Fungsi untuk memuat data baru
  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    // Simulasi penundaan jaringan
    await Future.delayed(const Duration(milliseconds: 1000));

    int newIndex = _items.length + 1;
    int itemsToAdd = 15;

    // Batasi penambahan item agar tidak melebihi maxItems
    if (newIndex + itemsToAdd > maxItems) {
      itemsToAdd = maxItems - _items.length;
      _hasMore = false;
    }

    // Tambahkan item baru ke daftar
    List<String> newItems = [];
    for (int i = 0; i < itemsToAdd; i++) {
      newItems.add('Item ${newIndex + i}');
    }

    setState(() {
      _items.addAll(newItems);
      _isLoading = false;
    });
  }

  // Listener untuk mendeteksi posisi scroll
  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Pengguna mencapai bagian bawah
      _loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Infinite Scroll',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Scroll bottom',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: framework7Purple,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  _items.length +
                  (_hasMore ? 1 : 0), // Tambahkan 1 untuk indikator loading
              itemBuilder: (context, index) {
                if (index == _items.length && _hasMore) {
                  // Widget loading di bagian bawah
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    ),
                  );
                }

                // Item List
                return ListTile(
                  title: Text(_items[index]),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 0,
                  ),
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
