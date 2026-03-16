import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signup(String email, String password) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await user.user!.sendEmailVerification();
  }

  Future login(String email, String password) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (!user.user!.emailVerified) {
      throw Exception("Please verify email first");
    }

    return user;
  }

  User? currentUser() {
    return _auth.currentUser;
  }

  Future logout() async {
    await _auth.signOut();
  }
}