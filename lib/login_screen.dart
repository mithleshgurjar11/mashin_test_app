import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mashin_test_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signup_screen.dart';
import 'auth_service.dart';
import 'home_screen.dart';

/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool rememberMe = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    loadSaved();
  }

  void loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString("email") ?? "";
    passwordController.text = prefs.getString("password") ?? "";
    if(emailController.text.isNotEmpty){
      setState(() {
        rememberMe = true;
      });
    }
  }

  void saveLogin() async {

    final prefs = await SharedPreferences.getInstance();

    if(rememberMe){
      prefs.setString("email", emailController.text);
      prefs.setString("password", passwordController.text);
    }else{
      prefs.clear();
    }
  }

  void showToast(String msg){
    Fluttertoast.showToast(msg: msg);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthProvider>(builder: (BuildContext context, AuthProvider provider, _) {
      return Scaffold(
        appBar: AppBar(title: Text("Login")),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [

              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: "Password",
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

              Row(
                children: [

                  Checkbox(
                    value: rememberMe,
                    onChanged: (value){
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),

                  Text("Remember Me")
                ],
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {

                  try{

                    await authService.login(
                      emailController.text,
                      passwordController.text,
                    );

                    saveLogin();

                    showToast("Login Successful");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomeScreen()),
                    );

                  }catch(e){
                    showToast(e.toString());
                  }

                },
                child: Text("Login"),
              ),

              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignupScreen(),
                    ),
                  );
                },
                child: Text("Create Account"),
              )
            ],
          ),
        ),
      );
    }
    );
  }
}*/
class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<AuthProvider>(context, listen: false).loadSaved();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: provider.emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: provider.passwordController,
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

            Row(
              children: [

                Checkbox(
                  value: provider.rememberMe,
                  onChanged: (v) => provider.toggleRemember(v!),
                ),

                Text("Remember Me")
              ],
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () => provider.login(context),
              child: Text("Login"),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SignupScreen()),
                );
              },
              child: Text("Create Account"),
            )
          ],
        ),
      ),
    );
  }
}
