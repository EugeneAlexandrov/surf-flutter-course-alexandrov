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
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 32,
                height: 1.125,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: 'С',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                  children: [
                    TextSpan(
                        text: 'писок',
                        style:
                            TextStyle(color: Color(0xff3b3e5b)))
                  ],
                ),
                TextSpan(
                  text: '\nи',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  children: [
                    TextSpan(
                        text: 'нтересных мест',
                        style:
                            TextStyle(color: Color(0xff3b3e5b)))
                  ],
                )
              ],
            ),
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
