import 'package:flutter/material.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/ui/screens/filters_screen/filters_screen.dart';
import 'package:places/ui/screens/new_place_screen/filter_type_picker_screen.dart';
import 'package:places/ui/screens/new_place_screen/new_place_screen.dart';
import 'package:places/ui/screens/search_screen/search_screen.dart';
import 'package:places/ui/screens/splash_screen/splash_screen.dart';
import 'package:places/ui/screens/details_screen/details_screen.dart';
import 'package:places/ui/screens/start_screen/start_screen.dart';

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
          builder: (_) => const AddPlaceScreen(),
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
        final place = arguments['place'] as Place;
        return MaterialPageRoute<Object?>(
          builder: (_) => DetailsScreen(place),
        );
      case main:
      default:
        return MaterialPageRoute<Object?>(
          builder: (_) => const StartScreen(),
        );
    }
  }
}
//
