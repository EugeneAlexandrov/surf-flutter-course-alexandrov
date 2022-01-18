import 'package:flutter/material.dart';
import 'package:places/main_page.dart';
import 'package:places/ui/screen/res/config.dart';
import 'package:places/ui/screen/res/themes.dart';
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
    return MaterialApp(
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      home: const MainPage(),
    );
  }
}
