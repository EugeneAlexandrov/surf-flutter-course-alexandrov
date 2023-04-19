import 'package:flutter/material.dart';

class BackgroundImageContainer extends StatefulWidget {
  BackgroundImageContainer({required this.url, Key? key}) : super(key: key);

  String url;

  @override
  _BackgroundImageContainerState createState() =>
      _BackgroundImageContainerState();
}

class _BackgroundImageContainerState extends State<BackgroundImageContainer> {
  Widget container = Container(
    child: const LinearProgressIndicator(),
    height: 96,
    alignment: Alignment.bottomCenter,
  );

  void changeLoader() async {
    //  await Future.delayed(const Duration(seconds: 5));
    setState(() {
      container = Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(
                Colors.black38,
                BlendMode.darken,
              ),
              image: NetworkImage(widget.url)),
        ),
        height: 96,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    changeLoader();
    return Container(child: container);
  }
}
