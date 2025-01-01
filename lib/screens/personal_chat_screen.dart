import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input.dart';

class PersonalChatScreen extends StatelessWidget {
  final String chatId;
  PersonalChatScreen({super.key, required this.chatId});

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('personal_chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ChatBubble(
                      message: message['text'],
                      isMe: message['senderId'] == _auth.currentUser!.uid,
                    );
                  },
                );
              },
            ),
          ),
          // Pass both chatType and chatId
          ChatInputField(
            chatType: 'personal_chats', // Pass 'personal_chats' as chatType
            chatId: chatId, // Pass the chatId
          ),
        ],
      ),
    );
  }
}
