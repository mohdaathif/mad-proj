import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_proj/auth/auth_page.dart';
import 'package:mad_proj/pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:
            FirebaseAuth.instance
                .authStateChanges(), // checks if logged in or not
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if already previously logged in
            return HomePage(); // open home page
          } else {
            // otherwise
            return AuthPage(); //open login page
          }
        },
      ),
    );
  }
}
