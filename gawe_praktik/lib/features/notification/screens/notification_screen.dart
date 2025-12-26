import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import widget kartu
import '../widgets/notification_card.dart';
// <-- 1. IMPORT CUSTOM DRAWER
// Path ini sudah benar dan aman karena custom_drawer tidak meng-import file ini
import '../../../widgets/custom_drawer.dart';

// <-- 2. UBAH JADI STATEFULWIDGET
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // <-- 3. TAMBAHKAN SCAFFOLD KEY
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey, // <-- 4. GUNAKAN KEY
      // <-- 5. TAMBAHKAN DRAWER
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.primaryColor),
          onPressed: () {
            Navigator.of(context).pop(); // Aksi kembali yang benar
          },
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          // <-- 6. UBAH JADI ICONBUTTON
          IconButton(
            onPressed: () {
              // Aksi untuk membuka drawer
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(Icons.more_vert, color: theme.primaryColor),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          // Notifikasi 1: Apply Success (10h ago)
          NotificationCard(
            title: 'Apply Success',
            description:
                'You has apply an job in Queenify Group as UI Designer',
            time: '10h ago',
            indicatorColor: Colors.green, // Warna status tetap
          ),
          SizedBox(height: 12),

          // Notifikasi 2: Interview Calls (9h ago)
          NotificationCard(
            title: 'Interview Calls',
            description: 'Congratulations! You have interview calls',
            time: '9h ago',
            indicatorColor: Color(0xFF9C27B0), // Warna ungu
          ),
          SizedBox(height: 12),

          // Notifikasi 3: Apply Success (8h ago)
          NotificationCard(
            title: 'Apply Success',
            description:
                'You has apply an job in Queenify Group as UI Designer',
            time: '8h ago',
            indicatorColor: Colors.blue, // Warna biru
          ),
          SizedBox(height: 12),

          // Notifikasi 4: Complete your profile (4h ago)
          NotificationCard(
            title: 'Complete your profile',
            description:
                'Please verify your profile information to continue using this app',
            time: '4h ago',
            indicatorColor: Colors.teal, // Warna hijau/biru
          ),
        ],
      ),
    );
  }
}
