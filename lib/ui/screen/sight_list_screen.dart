import 'package:flutter/material.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  _SightListScreenState createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: const Text(
            'Список\nинтересных мест',
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color.fromARGB(255, 25, 28, 49),
              fontSize: 32,
              height: 0.96,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
