import 'package:flutter/material.dart';
import 'package:places/app_router.dart';
import 'package:places/domain/model/sight.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/favorite_icon_button.dart';
import 'package:places/ui/screens/res/custom_color_scheme.dart';
import 'package:provider/provider.dart';

class SightCard extends StatelessWidget {
  const SightCard({required this.sightID, Key? key}) : super(key: key);

  final int sightID;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer2<FilterRepository, SightRepository>(builder: (context,
        FilterRepository filterRepository,
        SightRepository sightRepository,
        child) {
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
                        sightRepository.getSightById(sightID).name,
                        style: theme.textTheme.bodyText1,
                      ),
                      Text(
                        sightRepository.getSightById(sightID).details,
                        style: theme.textTheme.bodyText2?.copyWith(
                            color: theme
                                .extension<CustomColors>()!
                                .smallSecondaryTwo),
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
                filterRepository
                    .getFilterById(
                        sightRepository.getSightById(sightID).filterId)
                    .title,
                style: theme.textTheme.caption,
              ),
            ),
            //Ripple effect behind card
            Positioned.fill(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  splashColor: AppColors.dmInnactiveBlack,
                  onTap: () {
                    onSightTap(context, sightRepository.getSightById(sightID));
                  },
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: FavoriteIconButton(sightID),
            ),
          ],
        ),
      );
    });
  }

  void onSightTap(BuildContext context, Sight sight) {
    // navigate to SightDetailsScreen
    Navigator.of(context).pushNamed(
      AppRouter.sightDetail,
      arguments: {'sight': sight},
    );
    //
  }
}
