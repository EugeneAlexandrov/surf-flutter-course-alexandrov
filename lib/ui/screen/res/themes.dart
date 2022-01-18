import 'package:flutter/material.dart';
import 'package:places/styles.dart';

import '../../../colors.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void togleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      cardColor: lmCardBackground,
      scaffoldBackgroundColor: lmBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lmBackground,
        selectedItemColor: lmSecondaryColor,
        unselectedItemColor: lmSecondaryColor,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: lmSecondaryColor),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: lmInnactiveBlackColor,
      ),
      textTheme: TextTheme(
        headline6: title.copyWith(
          color: lmMainColor,
        ),
        bodyText1: text.copyWith(
          color: lmSecondaryColor,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      cardColor: dmDark,
      scaffoldBackgroundColor: dmMainColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: dmMainColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: lmSecondaryColor,
        unselectedLabelColor: lmSecondaryColor2,
      ),
      textTheme: TextTheme(
        headline6: title.copyWith(
          color: Colors.white,
        ),
        bodyText1: text.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}
