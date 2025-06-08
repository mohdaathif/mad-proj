import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  // void callback is method you can ascribe to gesture detector
  final VoidCallback showRegisterPage;

  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign in method
  Future<void> signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password.')),
      );
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        Navigator.pushReplacementNamed(context, '/home_page');
      } else {
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please verify your email before logging in.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final msg =
            e.code == 'user-not-found'
                ? 'No user found for that email.'
                : e.code == 'wrong-password'
                ? 'Wrong password.'
                : 'Login failed: ${e.message}';

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      });
    }
  }

  // dispose of controllers when not using
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fitness_center_rounded,
                  size: 90,
                  color: colorScheme.inversePrimary,
                ),

                SizedBox(height: 65),

                // Hello again!
                Text(
                  'Hello Again',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                    color: colorScheme.inversePrimary,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Welcome back to Lyfted!',
                  style: TextStyle(
                    fontSize: 20,
                    color: colorScheme.inversePrimary,
                  ),
                ),

                SizedBox(height: 50),

                // Username (email) text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      border: Border.all(color: colorScheme.secondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: colorScheme.inversePrimary,
                          ),
                        ),
                        style: TextStyle(color: colorScheme.inversePrimary),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      border: Border.all(color: colorScheme.secondary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: colorScheme.inversePrimary,
                          ),
                        ),
                        style: TextStyle(color: colorScheme.inversePrimary),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                // Sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                // Not a member?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3.0),
                      child: Text(
                        'Not a member?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Register Now!',
                        style: TextStyle(
                          color: colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
