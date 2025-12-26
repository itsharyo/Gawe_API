import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
const Color notificationBackground = Color(
  0xFFE8F0FE,
); // Biru muda/lavender untuk background notifikasi
const Color notificationIconColor = Color(
  0xFF9147FF,
); // Ungu untuk ikon notifikasi

// ----------------------------------------------------
// 1. Notification Content Widget (Custom Toast/Overlay)
// ----------------------------------------------------

class NotificationContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String message;
  final bool showCloseButton;
  final bool closeOnClick;
  final VoidCallback? onClose;
  final VoidCallback? onNotificationTap;

  const NotificationContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.message,
    this.showCloseButton = false,
    this.closeOnClick = false,
    this.onClose,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0), // Margin samping
      decoration: BoxDecoration(
        color: notificationBackground,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: closeOnClick ? onNotificationTap : null,
          borderRadius: BorderRadius.circular(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Ikon Notifikasi (Ungu)
              Padding(
                padding: const EdgeInsets.only(top: 2.0, right: 10.0),
                child: Icon(
                  Icons
                      .phone_android, // Ganti dengan ikon yang sesuai (disini saya menggunakan ikon telepon)
                  color: notificationIconColor,
                  size: 24,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Title dan Waktu
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$title · now',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    // Subtitle
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    // Message
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              // Tombol Close
              if (showCloseButton)
                GestureDetector(
                  onTap: onNotificationTap,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 2.0),
                    child: Icon(Icons.close, color: Colors.black54, size: 20),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 2. Notification Manager Class (Overlay Logic)
// ----------------------------------------------------

class NotificationManager {
  static OverlayEntry? _overlayEntry;

  static void showNotification(
    BuildContext context,
    NotificationContent content, {
    Duration duration = const Duration(seconds: 4),
  }) {
    // Tutup notifikasi sebelumnya jika ada
    dismissNotification();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top:
            MediaQuery.of(context).padding.top +
            10, // Posisi di bawah status bar
        left: 0,
        right: 0,
        child: content,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Otomatis tutup setelah durasi tertentu jika tidak diatur untuk closeOnClick
    if (!content.closeOnClick && content.showCloseButton == false) {
      Future.delayed(duration, () {
        dismissNotification(onCloseCallback: content.onClose);
      });
    }
  }

  static void dismissNotification({VoidCallback? onCloseCallback}) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      onCloseCallback?.call();
    }
  }
}

// ----------------------------------------------------
// 3. Notifications Page (Halaman Utama)
// ----------------------------------------------------

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  // Widget Pembantu untuk Tombol Ungu
  Widget _buildPurpleButton(String title, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: framework7Purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  // --- Logika Notifikasi ---

  // 1. Full Layout Notification (Gambar 2)
  void _showFullLayoutNotification(BuildContext context) {
    NotificationManager.showNotification(
      context,
      const NotificationContent(
        title: 'Framework7',
        subtitle: 'This is a subtitle',
        message: 'This is a simple notification message',
      ),
    );
  }

  // 2. With Close Button (Gambar 4)
  void _showWithCloseButtonNotification(BuildContext context) {
    NotificationManager.showNotification(
      context,
      NotificationContent(
        title: 'Framework7',
        subtitle: 'Notification with close button',
        message: 'Click (x) button to close me',
        showCloseButton: true,
        onNotificationTap: () => NotificationManager.dismissNotification(),
      ),
      duration: const Duration(hours: 1), // Atur durasi panjang agar tetap ada
    );
  }

  // 3. Click to Close (Gambar 3/5)
  void _showClickToCloseNotification(BuildContext context) {
    NotificationManager.showNotification(
      context,
      NotificationContent(
        title: 'Framework7',
        subtitle: 'Notification with close on click',
        message: 'Click me to close',
        closeOnClick: true,
        onNotificationTap: () => NotificationManager.dismissNotification(),
      ),
      duration: const Duration(hours: 1), // Atur durasi panjang agar tetap ada
    );
  }

  // 4. Callback on Close (Gambar 5 -> Dialog Gambar 6)
  void _showCallbackOnCloseNotification(BuildContext context) {
    void showDialogOnClose() {
      // Logic untuk menampilkan dialog "Notification closed" (Gambar 6)
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: lightPurpleBackground,
            title: const Text('Framework7'),
            content: const Text('Notification closed'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text(
                  'OK',
                  style: TextStyle(color: framework7Purple),
                ),
              ),
            ],
          );
        },
      );
    }

    NotificationManager.showNotification(
      context,
      NotificationContent(
        title: 'Framework7',
        subtitle: 'Notification with close on click',
        message: 'Click me to close',
        closeOnClick: true,
        // Callback akan dipanggil saat notifikasi ditutup, baik karena tap atau timeout
        onClose: showDialogOnClose,
        onNotificationTap: () => NotificationManager.dismissNotification(
          onCloseCallback: showDialogOnClose,
        ),
      ),
      duration: const Duration(
        seconds: 4,
      ), // Atur durasi singkat untuk melihat callback pada timeout
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
              'Notifications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Teks Pengantar
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Framework7 comes with simple Notifications component that allows you to show some useful messages to user and request basic actions.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            // Tombol 1: Full layout notification (Gambar 2)
            _buildPurpleButton(
              'Full layout notification',
              () => _showFullLayoutNotification(context),
            ),

            // Tombol 2: With close button (Gambar 4)
            _buildPurpleButton(
              'With close button',
              () => _showWithCloseButtonNotification(context),
            ),

            // Tombol 3: Click to close (Gambar 3/5)
            _buildPurpleButton(
              'Click to close',
              () => _showClickToCloseNotification(context),
            ),

            // Tombol 4: Callback on close (Gambar 5 -> Dialog Gambar 6)
            _buildPurpleButton(
              'Callback on close',
              () => _showCallbackOnCloseNotification(context),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
