import 'package:flutter/material.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screens/add_sight_screen.dart/add_sight_screen.dart';
import 'package:places/ui/screens/add_sight_screen.dart/filter_type_picker_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/search_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';

// routes
class AppRouter {
  static const String splash = '/splash';
  static const String main = '/main_screen';
  static const String onboarding = '/onBoarding';
  static const String filters = '/main_screen/filters';
  static const String addSight = '/main_screen/addSight';
  static const String sightDetail = '/main_screen/details';
  static const String chooseFilter = '/main_screen/addSight/chooseFilter';
  static const String searchScreen = '/main_screen/addSight/search';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<Object?>(
          builder: (_) => const SplashScreen(),
        );
      case filters:
        return MaterialPageRoute<Object?>(
          builder: (_) => const FiltersScreen(),
        );
      case addSight:
        return MaterialPageRoute<Object?>(
          builder: (_) => const NewSightScreen(),
        );
      case chooseFilter:
        return MaterialPageRoute<Object?>(
          builder: (_) => const FilterTypePickerScreen(),
        );
      case searchScreen:
        return MaterialPageRoute<Object?>(
          builder: (_) => const SearchScreen(),
        );
      case sightDetail:
        final arguments = settings.arguments as Map<String, dynamic>;
        final sight = arguments['sight'] as Sight;
        return MaterialPageRoute<Object?>(
          builder: (_) => SightDetailsScreen(sight),
        );
      case main:
      default:
        return MaterialPageRoute<Object?>(
          builder: (_) => const MainPage(),
        );
    }
  }
}
//
