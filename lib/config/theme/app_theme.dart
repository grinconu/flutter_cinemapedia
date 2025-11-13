import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getLightTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.orange,
    brightness: Brightness.light,
  );

  ThemeData getDarkTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.orange,
    brightness: Brightness.dark,
  );
}
