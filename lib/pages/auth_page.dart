import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app_web/main.dart';
import 'package:namer_app_web/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user logged in

          if (snapshot.hasData) {
            return MyHomePage();
          }
          //user is NOT logged in
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
