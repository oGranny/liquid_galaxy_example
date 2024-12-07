import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true, brightness: Brightness.dark,
  // primaryColor: Colors.grey.shade500,
  // scaffoldBackgroundColor: Colors.grey.shade900,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade800,
    contentTextStyle: TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
  ),
);
