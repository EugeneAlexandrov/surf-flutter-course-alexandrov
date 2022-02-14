import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/screens/res/themes.dart';

//Screen with sight card details
class SightDetailsScreen extends StatelessWidget {
  const SightDetailsScreen({Key? key, required this.sight}) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DetailsInfo(
        sight: sight,
      ),
    );
  }
}

class DetailsInfo extends StatefulWidget {
  const DetailsInfo({Key? key, required this.sight}) : super(key: key);

  final Sight sight;

  @override
  _DetailsInfoState createState() => _DetailsInfoState();
}

class _DetailsInfoState extends State<DetailsInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.sight.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(children: [
            Text(
              widget.sight.type,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Theme.of(context).colorScheme.smallBoldSecondary,
                  ),
            ),
            const SizedBox(width: 16),
            Text(
              AppStrings.detailsScreenTime,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).colorScheme.smallSecondaryTwo,
                  ),
            ),
          ]),
          const SizedBox(height: 24),
          Text(widget.sight.details,
              style: Theme.of(context).textTheme.bodyText2),
          const SizedBox(height: 24),
//TODO replace placeholder with ElevatedButton
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 0.8,
            color: const Color.fromRGBO(124, 126, 146, 0.24),
          ),
          const SizedBox(height: 8),
          //placeholder for two buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //TODO replace by TextButton
              SizedBox(
                height: 40,
                child: Row(children: [
                  SvgPicture.asset(
                    AssetImages.iconCalendarPath,
                    color: Theme.of(context).colorScheme.smallInnactive,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    AppStrings.detailsScreenPlanButton,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).colorScheme.smallInnactive,
                        ),
                  ),
                ]),
              ),
              //TODO replace by TextButton
              SizedBox(
                height: 40,
                child: Row(children: [
                  SvgPicture.asset(
                    AssetImages.iconHeartFillPath,
                    color: Colors.green,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(AppStrings.detailsScreenFavButton),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
