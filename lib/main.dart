import 'package:flutter/material.dart';
import 'package:places/app_router.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screens/add_sight_screen.dart/add_sight_screen.dart';
import 'package:places/ui/screens/add_sight_screen.dart/filter_type_picker_screen.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:provider/provider.dart';
import 'app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomTheme>(create: (_) => CustomTheme()),
        ChangeNotifierProvider<FilterRepository>(
          create: (_) => FilterRepository(),
        ),
        ChangeNotifierProvider<LocationRepository>(
          create: (_) => LocationRepository(),
        ),
        ChangeNotifierProxyProvider2<LocationRepository, FilterRepository,
            SightRepository>(
          create: (context) => SightRepository(),
          update: (context, locationRepository, filterRepository,
                  sightRepository) =>
              /*--- Не могу понять почему sightRepository nullable*/
              sightRepository!
                ..updateFilter(filterRepository)
                ..updateLocation(locationRepository),
        ),
      ],
      child: Consumer<CustomTheme>(
        builder: (context, CustomTheme customTheme, child) {
          return MaterialApp(
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: customTheme.currentTheme,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            routes: {
              AppRouter.main: (context) => const MainPage(),
              AppRouter.details: (context) {
                final id = ModalRoute.of(context)?.settings.arguments as int;
                return SightDetailsScreen(id: id);
              },
              AppRouter.filters: (context) => const FiltersScreen(),
              AppRouter.addSight: (context) => const NewSightScreen(),
              AppRouter.chooseFilter: (context) =>
                  const FilterTypePickerScreen(),
            },
            initialRoute: AppRouter.main,
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute<void>(builder: (context) {
                return const Scaffold(
                  body: Center(
                    child: Text('Ошибка пути'),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}
