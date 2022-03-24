import 'package:flutter/material.dart';
import 'package:places/app_router.dart';
import 'package:places/main_page.dart';
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
    return ChangeNotifierProvider(
      create: (_) => CustomTheme(),
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
                final index = ModalRoute.of(context)?.settings.arguments as int;
                return SightDetailsScreen(index: index);
              },
              AppRouter.filters: (context) => const FiltersScreen(),
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
