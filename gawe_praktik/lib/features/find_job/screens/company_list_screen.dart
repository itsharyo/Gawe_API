import 'package:flutter/material.dart';

// 1. Model Data Sederhana (untuk menampung data perusahaan)
class Company {
  final String logoAsset;
  final String name;
  final String location;
  final int jobCount;

  Company({
    required this.logoAsset,
    required this.name,
    required this.location,
    required this.jobCount,
  });
}

// 2. Data Dummy (ganti dengan data asli Anda nanti)
final List<Company> companies = [
  Company(
      logoAsset: 'assets/images/google_logo.png',
      name: 'Google',
      location: 'California, United States',
      jobCount: 10),
  Company(
      logoAsset: 'assets/images/microsoft_logo.png',
      name: 'Microsoft',
      location: 'Redmond, Washington, USA',
      jobCount: 9),
  Company(
      logoAsset: 'assets/images/twitter_logo.png',
      name: 'Twitter',
      location: 'San Francisco, United States',
      jobCount: 4),
  Company(
      logoAsset: 'assets/images/tencent_logo.png',
      name: 'Tencent',
      location: 'Shenzhen, china',
      jobCount: 4),
  // Ulangi data untuk membuat daftar lebih panjang (untuk scrolling)
  Company(
      logoAsset: 'assets/images/google_logo.png',
      name: 'Google',
      location: 'California, United States',
      jobCount: 10),
  Company(
      logoAsset: 'assets/images/microsoft_logo.png',
      name: 'Microsoft',
      location: 'Redmond, Washington, USA',
      jobCount: 9),
  Company(
      logoAsset: 'assets/images/twitter_logo.png',
      name: 'Twitter',
      location: 'San Francisco, United States',
      jobCount: 4),
  Company(
      logoAsset: 'assets/images/tencent_logo.png',
      name: 'Tencent',
      location: 'Shenzhen, china',
      jobCount: 4),
];

// 3. WIDGET UTAMA (SCREEN)
class CompanyListScreen extends StatelessWidget {
  const CompanyListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    final Color colorPurpleText = Color(0xFF6A26C4);
    final Color colorGreyText = Colors.grey[600]!;

    return Scaffold(
      // AppBar (sudah diatur oleh theme di main.dart)
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Company List",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              print("More options pressed");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 4. SEARCH BAR
          _buildSearchBar(colorGreyText),

          // 5. DAFTAR PERUSAHAAN (BISA SCROLL)
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                // Panggil widget card untuk setiap item
                return _buildCompanyCard(
                  context,
                  companies[index],
                  colorPurpleText,
                  colorGreyText,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget Bantuan untuk Search Bar
  Widget _buildSearchBar(Color colorGreyText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          onTap: () => print("Tapped company search field"),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: colorGreyText),
            hintText: "Type Company Name",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // Widget Bantuan untuk setiap Kartu Perusahaan
  Widget _buildCompanyCard(BuildContext context, Company company,
      Color colorPurpleText, Color colorGreyText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      // Material digunakan untuk bayangan (elevation) dan efek ripple
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        elevation: 1, // Bayangan tipis
        shadowColor: Colors.grey.withOpacity(0.2),
        child: InkWell(
          onTap: () {
            // Aksi saat kartu perusahaan ditekan
            print("Card pressed: ${company.name}");
            // Anda bisa navigasi ke halaman detail di sini
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // LOGO
                Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(4), // Sedikit padding untuk logo
                  decoration: BoxDecoration(
                    color: Colors.white, // Latar belakang logo
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey[200]!, width: 1),
                  ),
                  child: Image.asset(
                    company.logoAsset,
                    fit: BoxFit.contain,
                    // Error builder jika gambar gagal dimuat
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.business, color: colorGreyText);
                    },
                  ),
                ),
                const SizedBox(width: 16),

                // INFO (Nama, Lokasi, Jumlah Job)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Perusahaan
                      Text(
                        company.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorPurpleText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Lokasi
                      Text(
                        company.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: colorGreyText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Jumlah Job
                      Text(
                        "${company.jobCount} Jobs",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}