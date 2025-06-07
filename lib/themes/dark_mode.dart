import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.white,
    inversePrimary: Colors.grey.shade300,
    tertiary: Colors.grey.shade300,
    scrim: Colors.grey.shade900,
  ),
);
