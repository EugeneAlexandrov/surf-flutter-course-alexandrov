import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:places/app_router.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/domain/search_interactor/search_interactor.dart';
import 'package:places/domain/settings_interactor/settings_interactor.dart';
import 'package:places/services/geo/location_service.dart';
import 'package:places/ui/screens/start_screen/start_screen.dart';
import 'package:provider/provider.dart';
import 'app_strings.dart';
import 'data/repository/place_repository/place_repository_impl.dart';

final serviceLocator = GetIt.instance;

void setUp() {
  serviceLocator.registerSingleton<OnboardingShowModel>(OnboardingShowModel());
}

void main() {
  setUp();
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
        ChangeNotifierProvider<SettingsInteractor>(
            create: (_) => SettingsInteractor()),
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
    return Consumer<SettingsInteractor>(
      builder: (context, settingsInteractor, child) {
        return MaterialApp(
          theme: settingsInteractor.lightTheme,
          darkTheme: settingsInteractor.darkTheme,
          themeMode: settingsInteractor.currentTheme,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          initialRoute: AppRouter.splash,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
