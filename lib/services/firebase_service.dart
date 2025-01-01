import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create personal chat between two users
  Future<void> createPersonalChat(String user1Id, String user2Id) async {
    final chatId = user1Id.compareTo(user2Id) < 0
        ? '${user1Id}_$user2Id'
        : '${user2Id}_$user1Id';

    final chatDoc = _firestore.collection('personal_chats').doc(chatId);

    final chatExists = (await chatDoc.get()).exists;
    if (!chatExists) {
      await chatDoc.set({
        'participants': [user1Id, user2Id],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Send message to Firestore
  Future<void> sendMessage(
      String chatId, String message, String chatType) async {
    final currentUserId = _auth.currentUser?.uid;

    if (currentUserId != null) {
      final messageData = {
        'senderId': currentUserId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
      };

      // If chatType is personal, save to personal_chats, if not use community or vendor
      _firestore
          .collection(chatType)
          .doc(chatId)
          .collection('messages')
          .add(messageData);
    }
  }

  // Fetch messages from Firestore (personal, community, or vendor)
  Stream<QuerySnapshot> fetchMessages(String chatType, String chatId) {
    return _firestore
        .collection(chatType)
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Get current user's ID
  String getCurrentUserId() {
    return _auth.currentUser?.uid ?? '';
  }
}
