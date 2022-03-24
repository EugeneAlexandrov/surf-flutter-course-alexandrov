import 'package:flutter/material.dart';
import 'package:places/app_router.dart';
import 'package:places/colors.dart';
import 'package:places/data/mock_sights.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/favorite_icon_button.dart';
import 'package:places/ui/screens/res/themes.dart';

class SightCard extends StatelessWidget {
  const SightCard({required this.index, Key? key}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackgroundImageContainer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mockSights[index].name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      mockSights[index].details,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color:
                              Theme.of(context).colorScheme.smallSecondaryTwo),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Text(
              mockSights[index].type,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          //Ripple effect behind card
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: AppColors.dmInnactiveBlack,
                onTap: () {
                  onSightTap(context, index);
                },
              ),
            ),
          ),
          const Positioned(
            top: 4,
            right: 4,
            child: FavoriteIconButton(),
          ),
        ],
      ),
    );
  }

  void onSightTap(BuildContext context, int index) {
    Navigator.of(context).pushNamed(AppRouter.details,arguments: index);
  }
}
