import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle,
      home: SightListScreen(),
    );
  }
}
