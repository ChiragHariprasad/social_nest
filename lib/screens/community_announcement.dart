import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommunityChatScreen extends StatelessWidget {
  const CommunityChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Chat')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .doc('community')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var messages = snapshot.data!['messages'];
          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var msg = messages[index];
              return ListTile(
                title: Text(msg['text']),
                subtitle: Text(msg['sender']),
              );
            },
          );
        },
      ),
    );
  }
}
