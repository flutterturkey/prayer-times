import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeMode extends ChangeNotifier {
  final themePreference = "theme_preference";

  ThemeMode _themeMode;

  CustomThemeMode() {
    _loadTheme();
  }

  ThemeMode get getThemeMode => _themeMode;

  Future<void> _loadTheme() async {
    SharedPreferences.getInstance().then((prefs) {
      int preferredThemeIndex = prefs.getInt(themePreference) ?? 0;
      _themeMode = ThemeMode.values[preferredThemeIndex];
      notifyListeners();
    });
  }

  Future<void> setThemeMode(ThemeMode data) async {
    _themeMode = data;
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(themePreference, _themeMode.index);
    notifyListeners();
  }
}
