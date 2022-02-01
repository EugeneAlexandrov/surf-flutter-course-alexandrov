import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screen/res/themes.dart';

class SightCard extends StatelessWidget {
  const SightCard({required Sight sight, Key? key})
      : _sight = sight,
        super(key: key);

  final Sight _sight;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      elevation: 0,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ImageContainer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  _sight.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 2, 16, 16),
                child: Text(
                  _sight.details,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Theme.of(context).colorScheme.smallSecondaryTwo),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        _sight.type,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.favorite_border_outlined,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageContainer extends StatefulWidget {
  const ImageContainer({Key? key}) : super(key: key);

  @override
  _ImageContainerState createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
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
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
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
