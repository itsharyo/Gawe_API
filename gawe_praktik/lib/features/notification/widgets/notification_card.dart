import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Widget untuk setiap kartu notifikasi
class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final Color indicatorColor;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyMedium?.color ?? Colors.black87;
    final Color subTextColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ?? Colors.grey;

    return Card(
      color: theme.cardColor, // <-- Menggunakan warna dari Tema
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Indikator bulat/titik notifikasi
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                // Judul Notifikasi
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor, // <-- Menggunakan warna dari Tema
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Deskripsi Notifikasi
            Text(
              description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: subTextColor, // <-- Menggunakan warna dari Tema
              ),
            ),
            const SizedBox(height: 12),
            // Waktu dan tombol Mark as read
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: subTextColor, // <-- Menggunakan warna dari Tema
                  ),
                ),
                // Tombol "Mark as read"
                TextButton(
                  onPressed: () {
                    // Aksi untuk menandai sudah dibaca
                  },
                  child: Text(
                    'Mark as read',
                    style: GoogleFonts.poppins(
                      // <-- Menggunakan warna utama dari Tema
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
