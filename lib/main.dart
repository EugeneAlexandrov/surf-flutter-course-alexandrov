import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/sight_details.dart';
import 'package:places/ui/screen/sight_list_screen.dart';
import 'app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headline5: TextStyle(
            color: Color(0xff3B3E5B),
            fontFamily: 'Roboto',
            fontSize: 24,
            height: 1.125,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            color: Color(0xff3B3E5B),
            fontFamily: 'Roboto',
            fontSize: 14,
            height: 1.125,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      home: SightDetails(sight: sights[0]),
    );
  }
}
