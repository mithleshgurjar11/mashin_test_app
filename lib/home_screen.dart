import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = authService.currentUser();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [

          IconButton(
            onPressed: () async {

              await authService.logout();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );

            },
            icon: Icon(Icons.logout),
          )
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Welcome"),

            SizedBox(height:10),

            Text("User Email: ${user?.email}")
          ],
        ),
      ),
    );
  }
}