import 'package:flutter/material.dart';
import 'package:mashin_test_app/providers/login_signup_provider.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class OtpScreen extends StatefulWidget {

  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final otpController = TextEditingController();

  verifyOtp() async {

    final provider = Provider.of<LoginSignupProvider>(context, listen: false);

    await provider.verifyOtp(otpController.text);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginApiScreen()),
          (route) => false,
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            Text("OTP sent to ${widget.phone}"),

            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: verifyOtp,
              child: const Text("Verify"),
            )

          ],
        ),
      ),
    );
  }
}