import 'package:flutter/material.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.red,
      secondary: Colors.black,
    ),
    // appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.green,
      secondary: Colors.black,
    ).copyWith(
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
