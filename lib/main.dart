import 'package:flutter/material.dart';
import 'package:places/data/mock_sights.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screens/filters_screen.dart';
import 'package:places/ui/screens/res/config.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:provider/provider.dart';
import 'app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(
      create: (_) => CustomTheme(),
      child: Consumer<CustomTheme>(
        builder: (context, CustomTheme currentTheme, child) {
          return MaterialApp(
            theme: CustomTheme.lightTheme,
            darkTheme: CustomTheme.darkTheme,
            themeMode: currentTheme.currentTheme,
            debugShowCheckedModeBanner: false,
            title: AppStrings.appTitle,
            routes: {
              '/main_screen': (context) => const MainPage(),
              '/main_screen/details': (context) =>
                  SightDetailsScreen(sight: mockSights[2]),
              '/main_screen/filters': (context) => const FiltersScreen(),
            },
            initialRoute: '/main_screen',
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
