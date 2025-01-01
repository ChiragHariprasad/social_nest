import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/community_announcement.dart'; // Example screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CommunityChatScreen(), // Example screen
    );
  }
}
