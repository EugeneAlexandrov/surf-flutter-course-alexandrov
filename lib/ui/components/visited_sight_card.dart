import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/intention.dart';
import 'package:places/image_paths.dart';
import 'package:places/styles.dart';
import 'package:places/ui/screens/res/themes.dart';

class VisitedSightCard extends StatelessWidget {
  const VisitedSightCard({required Intention intention, Key? key})
      : _intention = intention,
        super(key: key);

  final Intention _intention;

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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _intention.sight.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      AppStrings.visitedCardGoalString +
                          getDate(_intention.date),
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color:
                                Theme.of(context).colorScheme.smallSecondaryTwo,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _intention.sight.details,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color:
                              Theme.of(context).colorScheme.smallSecondaryTwo),
                    ),
                  ],
                ),
              )
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
                        _intention.sight.type,
                        style: smallBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                //TODO replace svg by IconButton
                SvgPicture.asset(AssetImages.iconSharePath),
                const SizedBox(width: 22),
                //TODO replace svg by IconButton
                SvgPicture.asset(AssetImages.iconCrossPath),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getDate(DateTime date) {
    initializeDateFormatting();
    final formatter = DateFormat('dd MMM yyyy', 'ru_RU');
    return formatter.format(date);
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
    //await Future.delayed(const Duration(seconds: 5));
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
