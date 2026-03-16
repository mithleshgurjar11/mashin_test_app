import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mashin_test_app/providers/login_signup_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'otp_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String gender = "Male";

  File? image;

  Future pickImage(ImageSource source) async {

    final picked = await ImagePicker().pickImage(source: source);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  void signup() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final provider = Provider.of<LoginSignupProvider>(context, listen: false);

    UserModel user = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      mobile: phoneController.text.trim(),
      gender: gender,
      password: passwordController.text.trim(),
    );

    await provider.signup(user);

    await provider.sendOtp(phoneController.text);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(phone: phoneController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// Profile Image
              GestureDetector(
                onTap: () {

                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          ListTile(
                            title: const Text("Camera"),
                            onTap: () {
                              Navigator.pop(context);
                              pickImage(ImageSource.camera);
                            },
                          ),

                          ListTile(
                            title: const Text("Gallery"),
                            onTap: () {
                              Navigator.pop(context);
                              pickImage(ImageSource.gallery);
                            },
                          ),

                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  image != null ? FileImage(image!) : null,
                  child: image == null
                      ? const Icon(Icons.camera_alt)
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              /// Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),

              /// Mobile
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Mobile"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter mobile number";
                  }
                  if (value.length != 10) {
                    return "Enter valid 10 digit mobile";
                  }
                  return null;
                },
              ),

              /// Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }

                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Enter valid email";
                  }

                  return null;
                },
              ),

              /// Gender
              DropdownButtonFormField(
                value: gender,
                decoration: const InputDecoration(labelText: "Gender"),
                items: ["Male", "Female"].map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (v) {
                  setState(() {
                    gender = v!;
                  });
                },
              ),

              /// Password
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }

                  if (value.length < 6) {
                    return "Password must be 6 characters";
                  }

                  return null;
                },
              ),

              /// Confirm Password
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration:
                const InputDecoration(labelText: "Confirm Password"),
                validator: (value) {

                  if (value == null || value.isEmpty) {
                    return "Confirm password";
                  }

                  if (value != passwordController.text) {
                    return "Password not match";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: signup,
                child: const Text("Signup"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Already have account? Login"),
              )

            ],
          ),
        ),
      ),
    );
  }
}