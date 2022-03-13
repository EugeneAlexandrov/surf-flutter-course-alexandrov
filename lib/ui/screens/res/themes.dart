import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/colors.dart';
import 'package:places/styles.dart';

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void togleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.lmBackground,
          //statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: AppColors.lmGreen),
      cardTheme: const CardTheme(
        color: AppColors.lmBackground,
        margin: EdgeInsets.all(0),
      ),
      scaffoldBackgroundColor: Colors.white,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.lmSecondary,
        unselectedItemColor: AppColors.lmSecondary,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.lmSecondary),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.lmInnactiveBlack,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColors.lmGreen,
          fixedSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: small,
          primary: AppColors.lmSecondary,
        ),
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.lmGreen,
        thumbColor: Colors.white,
        inactiveTrackColor: AppColors.lmInnactiveBlack,
        trackHeight: 1,
      ),
      textTheme: TextTheme(
        headline6: subtitle.copyWith(
          color: AppColors.lmMain,
        ),
        headline5: title.copyWith(
          color: AppColors.lmSecondary,
        ),
        bodyText1: text.copyWith(
          color: AppColors.lmSecondary,
        ),
        bodyText2: small.copyWith(
          color: AppColors.lmSecondary,
        ),
        caption: smallBold.copyWith(
          color: Colors.white,
        ),
        headline1: superSmall.copyWith(
          color: AppColors.lmSecondary,
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.lmSecondary),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.dmMain,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.dmGreen),
        cardTheme: const CardTheme(
          color: AppColors.dmDark,
          margin: EdgeInsets.all(0),
        ),
        scaffoldBackgroundColor: AppColors.dmMain,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.dmMain,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
        ),
        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.lmSecondary,
          unselectedLabelColor: AppColors.lmSecondary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: AppColors.dmGreen,
            fixedSize: const Size(double.infinity, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: small,
            primary: Colors.white,
          ),
        ),
        sliderTheme: const SliderThemeData(
          activeTrackColor: AppColors.lmGreen,
          thumbColor: Colors.white,
          inactiveTrackColor: AppColors.lmInnactiveBlack,
          trackHeight: 1,
        ),
        textTheme: TextTheme(
          headline6: subtitle.copyWith(
            color: AppColors.dmInnactiveBlack,
          ),
          headline5: title.copyWith(
            color: Colors.white,
          ),
          bodyText1: text.copyWith(
            color: Colors.white,
          ),
          bodyText2: small.copyWith(
            color: Colors.white,
          ),
          caption: smallBold.copyWith(
            color: Colors.white,
          ),
          headline1: superSmall.copyWith(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white));
  }
}

extension CustomColorScheme on ColorScheme {
  Color get title =>
      brightness == Brightness.light ? AppColors.lmMain : Colors.white;
  Color get subTitle => brightness == Brightness.light
      ? AppColors.lmInnactiveBlack
      : AppColors.dmInnactiveBlack;
  Color get smallSecondaryTwo => brightness == Brightness.light
      ? AppColors.lmSecondaryTwo
      : AppColors.dmSecondaryTwo;
  Color get smallInnactive => brightness == Brightness.light
      ? AppColors.lmInnactiveBlack
      : AppColors.dmInnactiveBlack;
  Color get smallBoldInnactive => brightness == Brightness.light
      ? AppColors.lmInnactiveBlack
      : AppColors.dmInnactiveBlack;
  Color get smallBoldSecondary => brightness == Brightness.light
      ? AppColors.lmSecondary
      : AppColors.dmSecondary;
  Color get lmBackgroundDmDark => brightness == Brightness.light
      ? AppColors.lmBackground
      : AppColors.dmDark;
  Color get lmMainDmWhite =>
      brightness == Brightness.light ? AppColors.lmMain : Colors.white;
}
