import 'package:flutter/material.dart';
import 'package:mashin_test_app/providers/login_signup_provider.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';

class LoginApiScreen extends StatefulWidget {

  const LoginApiScreen({super.key});

  @override
  State<LoginApiScreen> createState() => _LoginApiScreenState();
}

class _LoginApiScreenState extends State<LoginApiScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {

    final provider = Provider.of<LoginSignupProvider>(context, listen: false);

    await provider.login(
      emailController.text,
      passwordController.text,
    );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SignupScreen(),
                  ),
                );
              },
              child: const Text("Create Account"),
            )

          ],
        ),
      ),
    );
  }
}