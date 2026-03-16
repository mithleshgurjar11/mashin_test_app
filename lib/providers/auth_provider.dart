import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mashin_test_app/home_screen.dart';
import 'package:mashin_test_app/login_screen.dart';
import 'package:mashin_test_app/verify_email_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  /// states
  bool rememberMe = false;
  bool hidePassword = true;
  bool confirmHidePassword = true;

  /// verify timer
  int seconds = 60;
  Timer? countdownTimer;
  Timer? verifyTimer;

  /// -------------------------------
  /// PASSWORD VISIBILITY
  /// -------------------------------

  void togglePassword() {

    hidePassword = !hidePassword;
    notifyListeners();
  }

  void toggleConfirmPassword() {

    confirmHidePassword = !confirmHidePassword;
    notifyListeners();
  }

  /// -------------------------------
  /// REMEMBER ME
  /// -------------------------------

  void toggleRemember(bool value) {

    rememberMe = value;
    notifyListeners();
  }

  /// -------------------------------
  /// LOAD SAVED LOGIN
  /// -------------------------------

  Future loadSaved() async {

    final prefs = await SharedPreferences.getInstance();

    emailController.text = prefs.getString("email") ?? "";
    passwordController.text = prefs.getString("password") ?? "";

    if (emailController.text.isNotEmpty) {
      rememberMe = true;
    }

    notifyListeners();
  }

  /// -------------------------------
  /// SAVE LOGIN
  /// -------------------------------

  Future saveLogin() async {

    final prefs = await SharedPreferences.getInstance();

    if (rememberMe) {

      prefs.setString("email", emailController.text);
      prefs.setString("password", passwordController.text);

    } else {

      prefs.clear();

    }
  }

  /// -------------------------------
  /// TOAST
  /// -------------------------------

  void showToast(String msg) {

    Fluttertoast.showToast(msg: msg);
  }

  /// -------------------------------
  /// LOGIN
  /// -------------------------------

  Future login(BuildContext context) async {

    try {

      UserCredential user = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!user.user!.emailVerified) {

        showToast("Please verify email first");
        return;
      }

      await saveLogin();

      showToast("Login Successful");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );

    } catch (e) {

      showToast(e.toString());
    }
  }

  /// -------------------------------
  /// SIGNUP
  /// -------------------------------

  Future signup(BuildContext context) async {

    if (newPasswordController.text != confirmController.text) {

      showToast("Password not match");
      return;
    }

    try {

      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: signupEmailController.text,
        password: newPasswordController.text,
      );

      await user.user!.sendEmailVerification();

      showToast("Signup successful");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyEmailScreen(
            email: signupEmailController.text,
          ),
        ),
      );

    } catch (e) {

      showToast(e.toString());
    }
  }

  /// -------------------------------
  /// COUNTDOWN
  /// -------------------------------

  void startCountdown() {

    seconds = 60;

    countdownTimer = Timer.periodic(

      const Duration(seconds: 1),

          (timer) {

        if (seconds == 0) {

          timer.cancel();

        } else {

          seconds--;

          notifyListeners();

        }

      },
    );
  }

  /// -------------------------------
  /// VERIFY CHECK
  /// -------------------------------

  void startVerificationCheck(BuildContext context) {

    verifyTimer = Timer.periodic(

      const Duration(seconds: 3),

          (timer) async {

        await FirebaseAuth.instance.currentUser?.reload();

        final user = FirebaseAuth.instance.currentUser;

        if (user != null && user.emailVerified) {

          verifyTimer?.cancel();
          countdownTimer?.cancel();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );

        }
      },
    );
  }

  /// -------------------------------
  /// DISPOSE TIMER
  /// -------------------------------

  void disposeTimer() {

    countdownTimer?.cancel();
    verifyTimer?.cancel();
  }

}