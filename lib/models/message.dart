import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String messageText; // Updated to match chat_bubble.dart usage
  final String senderId; // Updated to match chat_bubble.dart usage
  final Timestamp timestamp;

  Message({
    required this.messageText,
    required this.senderId,
    required this.timestamp,
  });

  factory Message.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      messageText: data['messageText'] ?? '',
      senderId: data['senderId'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageText': messageText,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }
}
