import 'package:flutter/material.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screens/add_sight_screen.dart/add_sight_screen.dart';
import 'package:places/ui/screens/add_sight_screen.dart/filter_type_picker_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/search_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String main = '/main_screen';
  static const String onboarding = '/onBoarding';
  static const String filters = '/main_screen/filters';
  static const String addSight = '/main_screen/addSight';
  static const String chooseFilter = '/main_screen/addSight/chooseFilter';
  static String searchScreen = '/main_screen/addSight/search';

  static Map<String, Widget Function(BuildContext context)> routes = {
    AppRouter.splash: (_) => const SplashScreen(),
    AppRouter.main: (_) => const MainPage(),
    AppRouter.onboarding: (_) => const OnboardingScreen(),
    AppRouter.filters: (_) => const FiltersScreen(),
    AppRouter.addSight: (_) => const NewSightScreen(),
    AppRouter.chooseFilter: (_) => const FilterTypePickerScreen(),
    AppRouter.searchScreen: (_) => const SearchScreen(),
  };
}
