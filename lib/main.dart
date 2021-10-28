import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MySecondWidget(),
    );
  }
}

class MyFirstWidget extends StatelessWidget {
  MyFirstWidget({Key? key}) : super(key: key);

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    counter++;
    print('MyFirstWidget build $counter');
    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}

class MySecondWidget extends StatefulWidget {
  const MySecondWidget({Key? key}) : super(key: key);

  @override
  _MySecondWidgetState createState() => _MySecondWidgetState();
}

class _MySecondWidgetState extends State<MySecondWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    counter++;
    print('MySecond Widget build: $counter');
    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}
