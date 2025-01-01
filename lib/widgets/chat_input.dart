import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For getting current user ID

class ChatInputField extends StatefulWidget {
  final String chatType; // Chat type (personal_chat, vendor_chat, etc.)
  final String chatId; // Chat ID (generated for personal chats)

  const ChatInputField(
      {super.key, required this.chatType, required this.chatId});

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseService _firebaseService =
      FirebaseService(); // Create FirebaseService instance

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      String userId =
          FirebaseAuth.instance.currentUser?.uid ?? ''; // Get current user ID
      _firebaseService.sendMessage(widget.chatId, message,
          widget.chatType); // Send message using FirebaseService
      _controller.clear(); // Clear the input field after sending message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
              onSubmitted: (_) =>
                  _sendMessage(), // Send message on pressing enter
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage, // Send message when icon is pressed
          ),
        ],
      ),
    );
  }
}
