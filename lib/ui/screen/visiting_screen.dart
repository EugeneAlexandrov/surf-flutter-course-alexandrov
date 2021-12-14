import 'package:flutter/material.dart';

//Third tab with visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
      ],
    );
  }
}
