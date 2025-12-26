import 'package:flutter/material.dart';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
// Ubah toastBackground default menjadi lebih terang/putih
const Color toastBackground = Color(0xFFF0F8FF);
// Gunakan Putih Murni atau sangat terang untuk toast yang di tengah
const Color centerToastBackground = Colors.white;

// ----------------------------------------------------
// 1. Toast Manager (Mengelola Overlay & Posisi)
// ----------------------------------------------------

enum ToastPosition { top, bottom, center }

class ToastManager {
  static OverlayEntry? _overlayEntry;

  static void show(
    BuildContext context, {
    required Widget content,
    required ToastPosition position,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onCloseCallback,
    List<Widget>? actions,
    Color? backgroundColor,
  }) {
    // Tutup toast sebelumnya jika ada
    dismiss();

    Alignment alignment;
    double? top, bottom;

    switch (position) {
      case ToastPosition.top:
        alignment = Alignment.topCenter;
        top = MediaQuery.of(context).padding.top + kToolbarHeight * 0.2;
        bottom = null;
        break; // 🚀 PERBAIKAN: Menambahkan break
      case ToastPosition.center:
        alignment = Alignment.center;
        top = null;
        bottom = null;
        break; // 🚀 PERBAIKAN: Menambahkan break
      case ToastPosition.bottom:
        // default:
        // Warning kuning di 'default:' sekarang hilang
        alignment = Alignment.bottomCenter;
        bottom = MediaQuery.of(context).padding.bottom + 20;
        top = null;
        break; // Break sudah ada
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        Widget toastWidget = Align(
          alignment: alignment,
          child: _CustomToast(
            content: content,
            actions: actions,
            backgroundColor: backgroundColor,
            onDismiss: () => dismiss(onCloseCallback: onCloseCallback),
          ),
        );

        // Jika posisinya center → tidak perlu Positioned
        if (position == ToastPosition.center) {
          return toastWidget;
        }

        // Selain center tetap gunakan Positioned
        return Positioned(
          top: top,
          bottom: bottom,
          left: 0,
          right: 0,
          child: toastWidget,
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Auto dismiss, kecuali jika ada tombol aksi atau callback
    if (actions == null && onCloseCallback == null) {
      Future.delayed(duration, () => dismiss());
    }
  }

  static void dismiss({VoidCallback? onCloseCallback}) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      onCloseCallback?.call();
    }
  }
}

// ----------------------------------------------------
// 2. Custom Toast Widget (Tampilan UI)
// ----------------------------------------------------

class _CustomToast extends StatelessWidget {
  final Widget content;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final VoidCallback? onDismiss;

  const _CustomToast({
    required this.content,
    this.actions,
    this.backgroundColor,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    bool hasActions = actions != null && actions!.isNotEmpty;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      color: backgroundColor ?? toastBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: IntrinsicWidth(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            hasActions ? 16 : 12,
            hasActions ? 8 : 12,
            hasActions ? 8 : 12,
            hasActions ? 8 : 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: content),
              if (hasActions) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 3. Toast Page (Halaman Utama)
// ----------------------------------------------------

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  // Widget Pembantu: Tombol Ungu
  Widget _buildPurpleButton(String title, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(bottom: 12.0),
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

  // Dialog yang muncul setelah callback
  void _showCallbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: lightPurpleBackground,
          title: const Text('Framework7'),
          content: const Text('Toast closed'),
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
              'Toast',
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
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Toasts provide brief feedback about an operation through a message on the screen.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            // 1. Toast on Bottom
            _buildPurpleButton(
              'Toast on Bottom',
              () => ToastManager.show(
                context,
                content: const Text('This is default bottom positioned toast'),
                position: ToastPosition.bottom,
                backgroundColor: toastBackground,
              ),
            ),

            // 2. Toast on Top
            _buildPurpleButton(
              'Toast on Top',
              () => ToastManager.show(
                context,
                content: const Text('Top positioned toast'),
                position: ToastPosition.top,
                backgroundColor: toastBackground,
              ),
            ),

            // 3. Toast on Center
            _buildPurpleButton(
              'Toast on Center',
              () => ToastManager.show(
                context,
                content: const Text('I\'m on center'),
                position: ToastPosition.center,
                backgroundColor: centerToastBackground,
              ),
            ),

            // 4. Toast with icon
            _buildPurpleButton(
              'Toast with icon',
              () => ToastManager.show(
                context,
                content: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.black, size: 30),
                    SizedBox(width: 8),
                    Text('I\'m with icon'),
                  ],
                ),
                position: ToastPosition.center,
                backgroundColor: centerToastBackground,
              ),
            ),

            // 5. Toast with large message
            _buildPurpleButton(
              'Toast with large message',
              () => ToastManager.show(
                context,
                content: const Text(
                  'This toast contains a lot of text. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil, quae, ab. Delectus amet optio facere autem sapiente quisquam beatae culpa dolore.',
                  style: TextStyle(fontSize: 14),
                ),
                duration: const Duration(seconds: 5),
                position: ToastPosition.bottom,
                backgroundColor: toastBackground,
              ),
            ),

            // 6. Toast with close button
            _buildPurpleButton(
              'Toast with close button',
              () => ToastManager.show(
                context,
                content: const Text('Toast with additional close button'),
                position: ToastPosition.bottom,
                backgroundColor: toastBackground,
                actions: [
                  TextButton(
                    onPressed: () => ToastManager.dismiss(),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: framework7Purple),
                    ),
                  ),
                ],
              ),
            ),

            // 7. Toast with custom button
            _buildPurpleButton(
              'Toast with custom button',
              () => ToastManager.show(
                context,
                content: const Text('Custom close button'),
                position: ToastPosition.bottom,
                backgroundColor: toastBackground,
                actions: [
                  TextButton(
                    onPressed: () => ToastManager.dismiss(),
                    child: const Text(
                      'Close Me',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),

            // 8. Toast with callback on close
            _buildPurpleButton('Toast with callback on close', () {
              ToastManager.show(
                context,
                content: const Text('Callback on close'),
                position: ToastPosition.bottom,
                backgroundColor: toastBackground,
                onCloseCallback: () => _showCallbackDialog(context),
                actions: [
                  TextButton(
                    onPressed: () => ToastManager.dismiss(
                      onCloseCallback: () => _showCallbackDialog(context),
                    ),
                    child: const Text(
                      'Ok',
                      style: TextStyle(color: framework7Purple),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
