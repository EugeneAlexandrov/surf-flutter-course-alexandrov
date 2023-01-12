import 'package:flutter/material.dart';
import 'package:places/app_router.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/domain/search_interactor/search_interactor.dart';
import 'package:places/services/geo/location_service.dart';
import 'package:places/ui/res/themes.dart';
import 'package:provider/provider.dart';
import 'app_strings.dart';
import 'data/repository/place_repository/place_repository_impl.dart';

void main() {
  runApp(
    const AppDependencies(
      app: App(),
    ),
  );
}

class AppDependencies extends StatefulWidget {
  final App app;

  const AppDependencies({required this.app, Key? key}) : super(key: key);

  @override
  State<AppDependencies> createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomTheme>(create: (_) => CustomTheme()),
        ChangeNotifierProvider<PlaceInteractor>(
          create: (_) => PlaceInteractor(
            PlaceRepositoryImpl(),
            LocationService(),
          ),
        ),
        ChangeNotifierProvider<SearchInteractor>(
            create: (_) => SearchInteractor(PlaceRepositoryImpl())),
      ],
      child: widget.app,
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomTheme>(
      builder: (context, CustomTheme customTheme, child) {
        return MaterialApp(
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: customTheme.currentTheme,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          initialRoute: AppRouter.splash,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
