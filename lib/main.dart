import 'package:flutter/material.dart';
import 'package:mad_proj/auth/auth_page.dart';
import 'package:mad_proj/models/shop.dart';
import 'package:mad_proj/pages/cart_page.dart';
import 'package:mad_proj/pages/connectivity_page.dart';
import 'package:mad_proj/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mad_proj/auth/main_page.dart';
import 'package:mad_proj/pages/shop_page.dart';
import 'package:mad_proj/themes/dark_mode.dart';
import 'package:mad_proj/themes/light_mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // wrap whole app in change notifier provider, gives shop class access to whole app
    // can now "listen" to Shop and rebuild when things change
    // or read data without listening
    ChangeNotifierProvider(create: (context) => Shop(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/home_page': (context) => const HomePage(),
        '/shop_page': (context) => const ShopPage(),
        '/cart_page': (context) => const CartPage(),
        '/auth_page': (context) => const AuthPage(),
        '/conn_page': (context) => const ConnectivityPage(),
      },
    );
  }
}
