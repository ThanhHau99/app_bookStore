import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDartMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool istrue) {
    themeMode = istrue ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
