import 'package:flutter/material.dart';
import 'package:places/app_router.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/intention_repository.dart';
import 'package:places/domain/repository/location_repository.dart';
import 'package:places/domain/repository/search_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';
import 'app_strings.dart';

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
        ChangeNotifierProvider<IntentionRepository>(
            create: (_) => IntentionRepository()),
        ChangeNotifierProvider<LocationRepository>(
          create: (_) => LocationRepository()..initLocation(),
        ),
        ChangeNotifierProxyProvider<LocationRepository, FilterRepository>(
          create: (context) => FilterRepository(
              Provider.of<LocationRepository>(context, listen: false)),
          update: (context, locationRepository, filterRepository) =>
              FilterRepository(locationRepository),
        ),
        ChangeNotifierProxyProvider<FilterRepository, SightRepository>(
          create: (context) => SightRepository(
              Provider.of<FilterRepository>(context, listen: false)),
          update: (context, filterRepository, sightRepository) =>
              SightRepository(filterRepository),
        ),
        ChangeNotifierProxyProvider<SightRepository, SearchRepository>(
            create: (context) => SearchRepository(
                Provider.of<SightRepository>(context, listen: false)),
            update: (context, sightRepository, searchRepository) =>
                SearchRepository(sightRepository)),
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
        return OnBoardindShowProvider(
          model: OnboardingShowModel(),
          child: MaterialApp(
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: customTheme.currentTheme,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            routes: AppRouter.routes,
            initialRoute: OnBoardindShowProvider.watch(context)?.shown ?? false
                ? AppRouter.main
                : AppRouter.onboarding,
            onGenerateRoute: (RouteSettings settings) {
              return MaterialPageRoute<void>(builder: (context) {
                return const Scaffold(
                  body: Center(
                    child: Text('Ошибка пути'),
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }
}

class OnboardingShowModel extends ChangeNotifier {
  bool _shown = false;

  bool get shown => _shown;

  void endShow() {
    _shown = true;
    notifyListeners();
  }
}

class OnBoardindShowProvider extends InheritedNotifier<OnboardingShowModel> {
  final OnboardingShowModel model;

  const OnBoardindShowProvider(
      {required this.model, required Widget child, Key? key})
      : super(key: key, notifier: model, child: child);

  //подписка
  static OnboardingShowModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnBoardindShowProvider>()
        ?.model;
  }

  //чтение
  static OnboardingShowModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<OnBoardindShowProvider>()
        ?.widget;
    return widget is OnBoardindShowProvider ? widget.notifier : null;
  }
}
