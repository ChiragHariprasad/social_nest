import 'package:flutter/material.dart';
import 'active_user_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Chat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Community Chat'),
              onPressed: () {
                Navigator.pushNamed(context, '/community');
              },
            ),
            ElevatedButton(
              child: Text('Personal Chats'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ActiveUsersScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
