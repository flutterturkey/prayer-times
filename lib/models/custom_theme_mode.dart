import 'package:flutter/material.dart';

class CustomThemeMode extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get getThemeMode => _themeMode;

  void setThemeMode(ThemeMode data) {
    _themeMode = data;
    notifyListeners();
  }
}
