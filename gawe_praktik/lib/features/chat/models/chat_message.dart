// import 'packageflutter/material.dart';

// ====================================================================
// A. MODEL DATA
// ====================================================================

// Model untuk item di daftar pesan
class MessageItem {
  final String name;
  final String lastMessage;
  final String time;
  final String status;
  final String avatarPath;

  MessageItem({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.status,
    required this.avatarPath,
  });
}

// Model untuk pesan di layar obrolan
enum MessageType { text, image }

enum Sender { user, other }

class ChatMessage {
  final String text;
  final String senderName;
  final Sender sender;
  final MessageType type;
  final String? imagePath;
  final String avatarPath;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.senderName,
    required this.sender,
    this.type = MessageType.text,
    this.imagePath,
    required this.avatarPath,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
