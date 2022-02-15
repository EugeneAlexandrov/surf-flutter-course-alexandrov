import 'package:flutter/material.dart';
import 'package:places/colors.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/favorite_icon_button.dart';
import 'package:places/ui/screens/res/themes.dart';

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
                      _sight.name,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      _sight.details,
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
              _sight.type,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          //Ripple effect behind card
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: AppColors.dmInnactiveBlack,
                onTap: () {
                  print('Tap ${_sight.name}');
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
}
