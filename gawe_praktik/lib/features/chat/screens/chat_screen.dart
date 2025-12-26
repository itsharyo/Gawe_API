import 'package:flutter/material.dart';
import '../models/chat_message.dart'; // Import models
import '../data/dummy_data.dart'; // Import dummy data (chatMessagesData, kittenImagePaths)
import '../widgets/chat_bubble.dart'; // Import ChatBubble
import '../widgets/chat_input_bar.dart'; // Import ChatInputBar

// Asumsi: Import CustomDrawerBody dari path di luar folder chat
// Ganti path ini sesuai struktur folder Anda yang sebenarnya.
import '../../../widgets/custom_drawer.dart'; // <--- Asumsi path

// ====================================================================
// C. LAYAR OBROLAN (ChatScreen)
// ====================================================================

class ChatScreen extends StatefulWidget {
  final String chatPartnerName;
  final String chatPartnerAvatarPath;

  const ChatScreen({
    super.key,
    required this.chatPartnerName,
    required this.chatPartnerAvatarPath,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Salin data chatMessagesData agar dapat dimodifikasi (menambah pesan baru)
  final List<ChatMessage> _messages = List.from(chatMessagesData);
  bool _isImagePickerVisible = false;

  void _sendMessage(ChatMessage message) {
    setState(() {
      _messages.insert(0, message);
      _isImagePickerVisible = false;
    });

    // Kirim balasan otomatis setelah jeda
    Future.delayed(const Duration(seconds: 1), () {
      _sendAutoReply(message);
    });
  }

  void _sendAutoReply(ChatMessage originalMessage) {
    // 1. Definisikan pasangan pengirim dan avatar yang mungkin membalas
    final otherPartners = [
      {'name': 'Kate', 'avatar': 'assets/images/g3.jpg'},
      {'name': 'Blue Ninja', 'avatar': 'assets/images/g9.jpg'},
    ];

    // Pilih lawan bicara secara acak (menggunakan waktu saat ini sebagai seed)
    final partner =
        otherPartners[DateTime.now().millisecond % otherPartners.length];

    final String partnerName = partner['name']!;
    final String partnerAvatar = partner['avatar']!;

    String replyText;

    if (originalMessage.type == MessageType.image) {
      // 1. Respon spesifik untuk gambar
      replyText = 'Oh my gosh, I love this! Super cute, thanks for sending!';
    } else {
      // 2. Pilih salah satu dari 5 balasan acak untuk pesan teks
      final responses = [
        'Tentu, saya akan segera memprosesnya. Terima kasih!', // Balasan profesional
        'Menarik! Saya setuju dengan poin Anda.', // Balasan setuju
        'Bisa dijelaskan lebih detail? Saya ingin memastikan saya mengerti.', // Balasan bertanya
        'Haha, itu lucu sekali! Saya akan mengingatnya.', // Balasan santai/humor
        'Diterima! Pesan Anda sudah masuk, tidak ada masalah.', // Balasan konfirmasi
      ];

      final responseIndex = DateTime.now().second % responses.length;
      replyText = responses[responseIndex];
    }

    final replyMessage = ChatMessage(
      text: replyText,
      senderName: partnerName,
      sender: Sender.other,
      avatarPath: partnerAvatar,
      timestamp: DateTime.now().add(const Duration(milliseconds: 500)),
    );

    setState(() {
      _messages.insert(0, replyMessage);
    });
  }

  // Logika untuk menampilkan nama hanya jika pengirim berbeda dari pesan sebelumnya
  bool _shouldShowName(int index) {
    if (_messages[index].sender == Sender.user) return false;
    if (index == 0) return true;

    return _messages[index].senderName != _messages[index - 1].senderName;
  }

  // Widget untuk tampilan Grid Gambar Kucing
  Widget _buildImageGrid() {
    return Container(
      height: 200, // Ketinggian untuk GridView
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 kolom
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: kittenImagePaths.length,
        itemBuilder: (context, index) {
          final imagePath = kittenImagePaths[index];
          return GestureDetector(
            onTap: () {
              final imageMessage = ChatMessage(
                text: '',
                senderName: 'Me',
                sender: Sender.user,
                type: MessageType.image,
                imagePath: imagePath,
                avatarPath: '',
              );
              _sendMessage(imageMessage); // Kirim gambar
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ScaffoldKey diperlukan untuk membuka drawer secara manual
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey, // Pasang key

      // 1. Ganti endDrawer menjadi drawer untuk muncul dari kiri
      drawer: const SizedBox(
        width: 320,
        child: Drawer(child: CustomDrawerBody()),
      ),
      // Hapus endDrawer
      // endDrawer: null,

      appBar: AppBar(
        // leading sekarang bisa menjadi IconButton untuk membuka Drawer
        leading: IconButton(
          // Ganti ikon kembali dengan ikon menu hamburger jika Anda ingin membukanya dari kiri.
          // Atau, pertahankan ikon kembali dan buka Drawer melalui tombol titik tiga.
          // Mari kita pertahankan fungsi kembali di leading, dan biarkan tombol titik tiga yang membuka Drawer (yang kini muncul dari kiri).
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.chatPartnerName,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
        centerTitle: false,
        actions: [
          // 2. Ganti Padding/Builder menjadi IconButton yang memanggil openDrawer()
          // Meskipun Drawer di kiri, kita bisa tetap membukanya dari tombol di kanan.
          // Gunakan Builder agar IconButton dapat mengakses Scaffold.
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.black),
                padding: const EdgeInsets.only(right: 8.0),
                onPressed: () {
                  // Panggil openDrawer() (bukan openEndDrawer)
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F0FF),
      body: Column(
        children: [
          // Tanggal
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Sunday, Feb 9, 12:58',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),

          // Daftar Pesan
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showName = _shouldShowName(index);

                return ChatBubble(
                  message: message,
                  showAvatarAndName: showName,
                );
              },
            ),
          ),

          // Grid Gambar Kucing (Jika isVisible = true)
          if (_isImagePickerVisible) _buildImageGrid(),

          // Input Bar
          ChatInputBar(
            onSendMessage: _sendMessage,
            // Callback untuk memunculkan/menyembunyikan grid gambar
            onCameraPressed: () {
              setState(() {
                _isImagePickerVisible = !_isImagePickerVisible;
              });
            },
          ),
        ],
      ),
    );
  }
}
