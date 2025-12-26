import 'package:flutter/material.dart';
import '../models/chat_message.dart'; // Import ChatMessage dan Sender

// --- WIDGET INPUT BAR DI BAWAH ---
class ChatInputBar extends StatefulWidget {
  final Function(ChatMessage) onSendMessage;
  final VoidCallback onCameraPressed;

  const ChatInputBar({
    super.key,
    required this.onSendMessage,
    required this.onCameraPressed,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final newMessage = ChatMessage(
        text: text,
        senderName: 'Me',
        sender: Sender.user,
        avatarPath: '',
      );
      widget.onSendMessage(newMessage);
      _controller.clear();
      setState(() {
        _isTyping = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Tombol Kamera/Galeri
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.grey),
              onPressed: widget.onCameraPressed,
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (text) {
                    setState(() {
                      _isTyping = text.isNotEmpty;
                    });
                  },
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  decoration: const InputDecoration(
                    hintText: 'Message',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Tombol Kirim Pesan
            IconButton(
              icon: Icon(
                Icons.send,
                color: _isTyping ? Colors.blue : Colors.grey,
              ),
              onPressed: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}
