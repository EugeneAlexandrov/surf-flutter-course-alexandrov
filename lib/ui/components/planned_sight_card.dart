import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/app_utils.dart';
import 'package:places/domain/repository/filter_repository.dart';
import 'package:places/domain/repository/intention_repository.dart';
import 'package:places/domain/repository/sight_repository.dart';
import 'package:places/image_paths.dart';
import 'package:places/styles.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class PlannedSightCard extends StatelessWidget {
  const PlannedSightCard(this._sightId, {Key? key}) : super(key: key);

  final int _sightId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final intention = Provider.of<IntentionRepository>(context, listen: false)
        .findIntentionBySightId(_sightId);
    final sight = Provider.of<SightRepository>(context, listen: false)
        .getSightById(_sightId);
    final filter = Provider.of<FilterRepository>(context, listen: false)
        .getFilterById(sight.filterId);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: UniqueKey(),
        onDismissed: (direction) {
          Provider.of<IntentionRepository>(context, listen: false)
              .changeFavoriteState(_sightId);
        },
        background: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.delete, size: 50, color: Colors.white),
                    Text(
                      'Удалить',
                      style: smallBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )),
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
                        sight.name,
                        style: theme.textTheme.bodyText1,
                      ),
                      Text(
                          AppStrings.plannedCardGoalString +
                              '${AppUtils.getDate(intention.date)}',
                          style: theme.textTheme.bodyText2?.copyWith(
                              color: AppUtils.getColor(intention.date))),
                      const SizedBox(height: 16),
                      Text(sight.details /*.details*/,
                          style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.colorScheme.smallSecondaryTwo)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                filter.title,
                style: smallBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 52,
              child: SizedBox(
                height: 40,
                width: 40,
                child: CustomIconButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    AssetImages.iconCalendarPath,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: SizedBox(
                height: 40,
                width: 40,
                child: CustomIconButton(
                  child: SvgPicture.asset(AssetImages.iconCrossPath),
                  onPressed: () {
                    Provider.of<IntentionRepository>(context, listen: false)
                        .delete(_sightId);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
