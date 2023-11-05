import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDOKBTfdsVy7ojBb6GvEknlnHKJHYRuPRw",
            authDomain: "communitybase-f5faf.firebaseapp.com",
            projectId: "communitybase-f5faf",
            storageBucket: "communitybase-f5faf.appspot.com",
            messagingSenderId: "4089162973",
            appId: "1:4089162973:web:1a7b20d6aa3a60511ebf34",
            measurementId: "G-EZYHRJ6CE5"));
  } else {
    await Firebase.initializeApp();
  }
}
