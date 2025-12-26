// import 'package:flutter/material.dart';
import '../models/chat_message.dart'; // Import models yang baru dibuat

// Data Dummy Gambar Kucing untuk Menu Kamera
final List<String> kittenImagePaths = [
  'assets/images/kucing1.jpeg',
  'assets/images/kucing2.png',
  'assets/images/kucing3.jpeg',
  'assets/images/kucing4.jpg',
  'assets/images/kucing5.jpg',
];

// Data Dummy untuk Daftar Pesan (Menggunakan Path Lokal)
final List<MessageItem> messagesData = [
  MessageItem(
    name: 'Sam Verdinand',
    lastMessage: 'OK. Lorem ipsum dolor sect...',
    time: '2m ago',
    status: 'Read',
    avatarPath: 'assets/images/g1.jpg',
  ),
  MessageItem(
    name: 'Freddie Ronan',
    lastMessage: 'Roger that sir, thankyou',
    time: '2m ago',
    status: 'Pending',
    avatarPath: 'assets/images/g2.jpg',
  ),
  MessageItem(
    name: 'Ethan Jacoby',
    lastMessage: 'Lorem ipsum dolor',
    time: '2d ago',
    status: 'Read',
    avatarPath: 'assets/images/g3.jpg',
  ),
  MessageItem(
    name: 'Alfie Mason',
    lastMessage: 'Lorem ipsum dolor sect...',
    time: '1h ago',
    status: 'Pending',
    avatarPath: 'assets/images/g4.jpg',
  ),
  MessageItem(
    name: 'Archie Parker',
    lastMessage: 'OK. Lorem ipsum dolor sect...',
    time: '5m ago',
    status: 'Read',
    avatarPath: 'assets/images/g5.jpg',
  ),
  MessageItem(
    name: 'Sam Verdinand',
    lastMessage: 'OK. Lorem ipsum dolor sect...',
    time: '1h ago',
    status: 'Read',
    avatarPath: 'assets/images/g6.jpg',
  ),
  MessageItem(
    name: 'Isaac Banford',
    lastMessage: 'Roger that sir, thankyou',
    time: '2h ago',
    status: 'Pending',
    avatarPath: 'assets/images/g7.jpg',
  ),
  MessageItem(
    name: 'Henry Hunter',
    lastMessage: 'Lorem ipsum dolor',
    time: '3h ago',
    status: 'Read',
    avatarPath: 'assets/images/g8.jpeg',
  ),
  MessageItem(
    name: 'Harry Parker',
    lastMessage: 'OK. Lorem ipsum dolor sect...',
    time: '4h ago',
    status: 'Pending',
    avatarPath: 'assets/images/g9.jpg',
  ),
  MessageItem(
    name: 'George Carson',
    lastMessage: 'OK. Lorem ipsum dolor sect...',
    time: '5h ago',
    status: 'Read',
    avatarPath: 'assets/images/g10.jpg',
  ),
];

// Data Dummy untuk Isi Obrolan Awal
final List<ChatMessage> chatMessagesData = [
  ChatMessage(
    text: 'Yes!',
    senderName: 'Blue Ninja',
    sender: Sender.other,
    avatarPath: 'assets/images/g9.jpg',
    timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
  ),
  ChatMessage(
    text: 'Awesome!',
    senderName: 'Blue Ninja',
    sender: Sender.other,
    avatarPath: 'assets/imagesg9.jpg',
    timestamp: DateTime.now().subtract(const Duration(minutes: 51)),
  ),
  ChatMessage(
    text: 'Like it very much!',
    senderName: 'Kate',
    sender: Sender.other,
    avatarPath: 'assets/images/g3.jpg',
    timestamp: DateTime.now().subtract(const Duration(minutes: 52)),
  ),
  ChatMessage(
    text: 'Nice!',
    senderName: 'Kate',
    sender: Sender.other,
    avatarPath: 'assets/images/g3.jpg',
    timestamp: DateTime.now().subtract(const Duration(minutes: 53)),
  ),
  ChatMessage(
    text: '',
    senderName: 'Me',
    sender: Sender.user,
    type: MessageType.image,
    imagePath: 'assets/images/kucing.jpg', // Path gambar kucing lokal
    avatarPath: '',
    timestamp: DateTime.now().subtract(const Duration(minutes: 54)),
  ),
  ChatMessage(
    text: 'Hey, look, cutest kitten ever!',
    senderName: 'Me',
    sender: Sender.user,
    avatarPath: '',
    timestamp: DateTime.now().subtract(const Duration(minutes: 55)),
  ),
  ChatMessage(
    text: 'Hey, Blue Ninja! Glad to see you ;)',
    senderName: 'Me',
    sender: Sender.user,
    avatarPath: '',
    timestamp: DateTime.now().subtract(const Duration(minutes: 56)),
  ),
  ChatMessage(
    text: 'Hi there, I am also fine, thanks! And how are you?',
    senderName: 'Blue Ninja',
    sender: Sender.other,
    avatarPath: 'assets/images/g9.jpg',
    timestamp: DateTime.now().subtract(const Duration(minutes: 57)),
  ),
  ChatMessage(
    text: 'Hi, I am good!',
    senderName: 'Kate',
    sender: Sender.other,
    avatarPath: 'assets/images/g3.jpg',
    timestamp: DateTime.now().subtract(const Duration(minutes: 58)),
  ),
  ChatMessage(
    text: 'How are you?',
    senderName: 'Me',
    sender: Sender.user,
    avatarPath: '',
    timestamp: DateTime.now().subtract(const Duration(minutes: 59)),
  ),
  ChatMessage(
    text: 'Hi, Kate',
    senderName: 'Me',
    sender: Sender.user,
    avatarPath: '',
    timestamp: DateTime.now().subtract(const Duration(minutes: 60)),
  ),
];
