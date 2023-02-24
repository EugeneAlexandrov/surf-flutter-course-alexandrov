import 'package:flutter/material.dart';
import 'package:places/ui/res/themes.dart';

class SettingsInteractor with ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDark => _isDarkTheme;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  ThemeData get lightTheme => CustomTheme.lightTheme;
  ThemeData get darkTheme => CustomTheme.darkTheme;

  void changeTheme(bool newValue) {
    _isDarkTheme = newValue;
    notifyListeners();
  }
}
