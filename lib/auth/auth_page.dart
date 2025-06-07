import 'package:flutter/material.dart';
import 'package:mad_proj/pages/login_page.dart';
import 'package:mad_proj/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // initially, show the login page
  bool showLoginPage = true;

  // switch screens
  void toggleScreens() {
    setState(() {
      showLoginPage =
          !showLoginPage; // reverse whatever current value of bool showLoginPage
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreens);
    } else {
      return RegisterPage(showLoginPage: toggleScreens);
    }
  }
}
