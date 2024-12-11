import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyB-uLLq629j9grYp7pMA5jZqbmWESuS9Uw",
      authDomain: "my-project-2bb00.firebaseapp.com",
      projectId: "my-project-2bb00",
      storageBucket: "my-project-2bb00.firebasestorage.app",
      messagingSenderId: "738935501237",
      appId: "1:738935501237:web:3262f25ac48d11f389e9fc",
      measurementId: "G-Z1C7K1HDC6", // Optional
    );
  }
}
