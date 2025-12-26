import 'package:flutter/material.dart';
import '../models/chat_message.dart'; // Import ChatMessage dan Sender

// --- WIDGET BUBBLE PESAN ---
class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool showAvatarAndName;

  const ChatBubble({
    super.key,
    required this.message,
    this.showAvatarAndName = true,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == Sender.user;
    final alignment = isUser ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = isUser ? const Color(0xFF1E88E5) : Colors.white;
    final textColor = isUser ? Colors.white : Colors.black;
    final radius = BorderRadius.circular(15);
    final borderRadius = isUser
        ? radius.copyWith(
            bottomRight: const Radius.circular(3),
            topLeft: const Radius.circular(15),
          )
        : radius.copyWith(
            bottomLeft: const Radius.circular(3),
            topRight: const Radius.circular(15),
          );

    Widget messageContent;
    if (message.type == MessageType.image) {
      messageContent = ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          message.imagePath!,
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      );
    } else {
      messageContent = Container(
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: borderRadius,
        ),
        child: Text(
          message.text,
          style: TextStyle(color: textColor, fontWeight: FontWeight.normal),
        ),
      );
    }

    return Container(
      alignment: alignment,
      margin: EdgeInsets.only(top: showAvatarAndName ? 15 : 4, bottom: 4),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(message.avatarPath),
                ),
                if (showAvatarAndName) const SizedBox(height: 4),
                if (showAvatarAndName)
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      message.senderName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 8),
          ],
          messageContent,
          if (isUser) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
