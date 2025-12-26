import 'package:flutter/material.dart';
import '../models/chat_message.dart'; // Import MessageItem
import '../screens/chat_screen.dart'; // Import ChatScreen untuk navigasi

// Widget untuk setiap item dalam daftar pesan (Menggunakan AssetImage)
class MessageListItem extends StatelessWidget {
  final MessageItem item;

  const MessageListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    Color statusColor =
        item.status == 'Read' ? const Color(0xFF9C27B0) : Colors.grey;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              chatPartnerName: item.name,
              chatPartnerAvatarPath: item.avatarPath,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            // Avatar Pengguna menggunakan AssetImage
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(item.avatarPath),
              backgroundColor: Colors.grey.shade300,
            ),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.lastMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Status Pesan
            Row(
              children: [
                Text(
                  item.status,
                  style: TextStyle(
                    fontSize: 14,
                    color: statusColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.done, // Centang satu
                  size: 16,
                  color: statusColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
