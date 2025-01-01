import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class ChatBody extends StatelessWidget {
  final String chatType; // Chat type (personal_chat, vendor_chat, etc.)
  final String chatId; // Chat ID (generated for personal chats)

  const ChatBody({super.key, required this.chatType, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseService().fetchMessages(
          chatType, chatId), // Fetch messages using FirebaseService
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No messages yet."));
        }

        var messages = snapshot.data!.docs;
        return ListView.builder(
          reverse: true, // Show latest message at the bottom
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var messageData = messages[index];
            var message = messageData['text'];
            var senderId = messageData['senderId'];
            var timestamp = messageData['timestamp'];

            return ListTile(
              title: Text(message),
              subtitle: Text(senderId),
              trailing: Text(
                timestamp != null
                    ? (timestamp as Timestamp).toDate().toString()
                    : 'No timestamp',
              ),
            );
          },
        );
      },
    );
  }
}
