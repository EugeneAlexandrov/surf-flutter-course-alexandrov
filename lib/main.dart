import 'package:flutter/material.dart';
import 'package:places/ui/screen/sight_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Places';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme:ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SightListScreen(_title),
    );
  }
}
