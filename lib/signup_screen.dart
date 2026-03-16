import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mashin_test_app/providers/auth_provider.dart';
import 'package:mashin_test_app/verify_email_screen.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';

/*
class SignupScreen extends StatefulWidget {

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmController = TextEditingController();

  final AuthService authService = AuthService();

  bool hidePassword = true;

  bool confirmHidePassword = true;

  void showToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Full Name"),
              ),

              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Mobile Number"),
              ),

              TextField(
                obscureText: hidePassword,
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: (){
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),

              TextField(
                controller: confirmController,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmHidePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: (){
                      setState(() {
                        confirmHidePassword = !confirmHidePassword;
                      });
                    },
                  ),
                ),
                obscureText: confirmHidePassword,

              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {

                  if(passwordController.text != confirmController.text){
                    showToast("Password not match");
                    return;
                  }

                  try{

                    await authService.signup(
                      emailController.text,
                      passwordController.text,
                    );

                    showToast("Signup successful");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VerifyEmailScreen(
                          email: emailController.text,
                        ),
                      ),
                    );

                  }catch(e){
                    showToast(e.toString());
                  }

                },
                child: Text("Signup"),
              )
            ],
          ),
        ),
      ),
    );
  }
}*/
class SignupScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: provider.nameController,
                decoration: InputDecoration(labelText: "Full Name"),
              ),

              TextField(
                controller: provider.signupEmailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: provider.phoneController,
                decoration: InputDecoration(labelText: "Mobile Number"),
              ),

              TextField(
                controller: provider.newPasswordController,
                obscureText: provider.hidePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(provider.hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: provider.togglePassword,
                  ),
                ),
              ),

              TextField(
                controller: provider.confirmController,
                obscureText: provider.confirmHidePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(provider.confirmHidePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: provider.toggleConfirmPassword,
                  ),
                ),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => provider.signup(context),
                child: Text("Signup"),
              )
            ],
          ),
        ),
      ),
    );
  }
}