import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'personal_chat_screen.dart';
import '../services/firebase_service.dart';

class ActiveUsersScreen extends StatelessWidget {
  const ActiveUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(title: const Text('Active Users')),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .where('isOnline', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  String currentUserId = auth.currentUser!.uid;
                  FirebaseService().createPersonalChat(currentUserId, user.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalChatScreen(chatId: user.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
