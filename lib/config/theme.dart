import 'package:flutter/material.dart';

ThemeData gymTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: const Color(0xFF3498DB),
    secondary: const Color(0xFF3498DB), 
    onPrimary: Colors.black,
    onSurfaceVariant: Colors.blue.shade100, 
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white, 
  ),
);
