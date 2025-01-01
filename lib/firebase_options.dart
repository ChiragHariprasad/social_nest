import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: "YOUR_WEB_API_KEY",
        authDomain: "your-project.firebaseapp.com",
        projectId: "your-project-id",
        storageBucket: "your-project.appspot.com",
        messagingSenderId: "SENDER_ID",
        appId: "APP_ID",
      );
    } else {
      return FirebaseOptions(
        apiKey: "YOUR_ANDROID_API_KEY",
        appId: "APP_ID",
        messagingSenderId: "SENDER_ID",
        projectId: "your-project-id",
        storageBucket: "your-project.appspot.com",
      );
    }
  }
}
