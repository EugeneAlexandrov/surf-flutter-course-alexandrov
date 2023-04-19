import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:places/data/mock_categories.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/favorite_icon_button.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:places/ui/components/details_bottomsheet.dart';
import 'package:provider/provider.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({required this.place, Key? key}) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<PlaceInteractor>(
        builder: (context, placeInteractor, child) {
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
                BackgroundImageContainer(url: place.urls[0]),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: theme.textTheme.bodyText1,
                      ),
                      Text(
                        place.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
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
                getFilterTitle(place.placeType),
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
                    onSightTap(context, place);
                  },
                ),
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: FavoriteIconButton(place.id),
            ),
          ],
        ),
      );
    });
  }

  void onSightTap(BuildContext context, Place place) {
    showFlexibleBottomSheet(
      minHeight: 0,
      initHeight: 0.8,
      maxHeight: 0.8,
      isExpand: false,
      context: context,
      builder: (
        BuildContext context,
        ScrollController scrollController,
        double bottomSheetOffset,
      ) {
        return DetailsBottomSheet(
          place: place,
          context: context,
          scrollController: scrollController,
          bottomSheetOffset: bottomSheetOffset,
        );
      },
    );
  }
}
