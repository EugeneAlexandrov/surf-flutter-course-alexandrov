import 'package:flutter/material.dart';
import 'package:places/image_paths.dart';

class BackgroundImageContainer extends StatefulWidget {
  const BackgroundImageContainer({Key? key}) : super(key: key);

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
        decoration: const BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black38,
                BlendMode.darken,
              ),
              image: ExactAssetImage(AssetImages.mockImageCardPath)),
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
