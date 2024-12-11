import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Signed in: ${userCredential.user?.email}');
    } catch (e) {
      print('Error: $e');
    }
  }

  // You can add other methods like sign up, sign out, etc.
}
