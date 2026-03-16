import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mashin_test_app/providers/auth_provider.dart';
import 'package:mashin_test_app/providers/login_signup_provider.dart';
import 'package:mashin_test_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: providers(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginScreen(),
      home: LoginApiScreen(),
    );
  }
}

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => LoginSignupProvider()),
  ];
}