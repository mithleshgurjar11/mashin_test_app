/*
class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  int seconds = 60;
  Timer? countdownTimer;
  Timer? verifyTimer;

  @override
  void initState() {
    super.initState();
    startCountdown();
    startVerificationCheck();
  }

  // countdown timer
  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {

      if (seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          seconds--;
        });
      }

    });
  }

  // email verification check every 3 seconds
  void startVerificationCheck() {

    verifyTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {

      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.emailVerified) {

        verifyTimer?.cancel();
        countdownTimer?.cancel();

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    verifyTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Please check your email and click verification link",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            Text(
              widget.email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "If email not found check SPAM folder",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            Center(
              child: Text(
                "Waiting for verification: $seconds sec",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class VerifyEmailScreen extends StatefulWidget {

  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  @override
  void initState() {
    super.initState();

    final provider = Provider.of<AuthProvider>(context, listen: false);

    provider.startCountdown();
    provider.startVerificationCheck(context);
  }

  @override
  void dispose() {

    Provider.of<AuthProvider>(context, listen: false).disposeTimer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Verify Email")),
      body: Center(
        child: Text(
          "Waiting for verification: ${provider.seconds}",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
