import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/app_utils.dart';
import 'package:places/data/mock_filters.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:places/ui/res/styles.dart';
import 'package:provider/provider.dart';

class VisitedPlaceCard extends StatelessWidget {
  const VisitedPlaceCard(this._placeId, {Key? key}) : super(key: key);

  final int _placeId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    final intention = Provider.of<PlaceInteractor>(context, listen: false)
        .findIntentionByPlaceId(_placeId);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: FutureBuilder(
          future: Provider.of<PlaceInteractor>(context, listen: false)
              .getPlace(_placeId),
          builder: (BuildContext context, AsyncSnapshot<Place> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              Place place = snapshot.data!;
              return Stack(
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
                              place.name /*.name*/,
                              style: theme.textTheme.bodyText1,
                            ),
                            Text(
                              AppStrings.visitedCardGoalString +
                                  '${AppUtils.dateToString(intention.date)}',
                              /*.date*/
                              style: theme.textTheme.bodyText2?.copyWith(
                                color: colors!.smallSecondaryTwo,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              place.description /*.details*/,
                              style: theme.textTheme.bodyText2
                                  ?.copyWith(color: colors!.smallSecondaryTwo),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      getFilterTitle(place.placeType) /*.type*/,
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
                          AssetImages.iconSharePath,
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
                          Provider.of<PlaceInteractor>(context, listen: false)
                              .removeFromFavorites(place.id);
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
