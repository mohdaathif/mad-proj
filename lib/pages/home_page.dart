import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mad_proj/components/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.fitness_center_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.tertiary,
            ),

            const SizedBox(height: 25),

            // title
            Text(
              "Welcome to Lyftd",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),

            const SizedBox(height: 10),
            // subtitle
            Text(
              "A Premium Fitness Store",
              style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
            ),

            const SizedBox(height: 10),
            // Already a member?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/auth_page');
                  },
                  child: Text(
                    'Not My Account',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            // button
            MyButton(
              onTap:
                  () => Navigator.pushReplacementNamed(context, '/shop_page'),
              child: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
