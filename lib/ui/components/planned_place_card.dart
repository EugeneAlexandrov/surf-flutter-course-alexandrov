import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/app_strings.dart';
import 'package:places/app_utils.dart';
import 'package:places/data/mock_categories.dart';
import 'package:places/domain/model/intention.dart';
import 'package:places/domain/model/place.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/res/custom_color_scheme.dart';
import 'package:places/ui/res/styles.dart';
import 'package:provider/provider.dart';

class PlannedPlaceCard extends StatelessWidget {
  const PlannedPlaceCard(this._placeId, {Key? key}) : super(key: key);

  final int _placeId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final intention = Provider.of<PlaceInteractor>(context, listen: false)
        .findIntentionByPlaceId(_placeId);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      child: FutureBuilder(
          future: Provider.of<PlaceInteractor>(context, listen: false)
              .getPlace(_placeId),
          builder: (BuildContext context, AsyncSnapshot<Place> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              Place place = snapshot.data!;
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: UniqueKey(),
                onDismissed: (direction) {
                  Provider.of<PlaceInteractor>(context, listen: false)
                      .changeFavoriteState(_placeId);
                },
                background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.delete,
                                size: 50, color: Colors.white),
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
                                place.name,
                                style: theme.textTheme.bodyText1,
                              ),
                              Text(
                                  AppStrings.plannedCardGoalString +
                                      '${AppUtils.dateToString(intention.date)}',
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: AppUtils.colorByDate(
                                          intention.date))),
                              const SizedBox(height: 16),
                              Text(place.description /*.details*/,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: theme
                                          .extension<CustomColors>()!
                                          .smallSecondaryTwo)),
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
                          onPressed: () async {
                            var date = await showCupertinoDatePicker(
                                context, intention);
                            if (date != null) {
                              Provider.of<PlaceInteractor>(context,
                                      listen: false)
                                  .changeDate(date, place.id);
                            }
                          },
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
                            Provider.of<PlaceInteractor>(context, listen: false)
                                .removeFromFavorites(place.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
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

Future<DateTime?> showCupertinoDatePicker(
    BuildContext context, Intention intention) async {
  DateTime? date;
  if (Platform.isAndroid) {
    date = await showDatePicker(
      context: context,
      initialDate: intention.date ?? DateTime.now(),
      firstDate: intention.date ?? DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
  } else {
    date = await showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoBottomSheet(intention),
    );
  }
  return date;
}

class CupertinoBottomSheet extends StatefulWidget {
  const CupertinoBottomSheet(this.intention, {Key? key}) : super(key: key);

  final Intention intention;

  @override
  State<CupertinoBottomSheet> createState() => _CupertinoBottomSheetState();
}

class _CupertinoBottomSheetState extends State<CupertinoBottomSheet> {
  DateTime? tmpDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<CustomColors>();
    return Container(
      height: 500,
      color: colors?.lmBackgroundDmMain,
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: widget.intention.date ?? DateTime.now(),
              minimumYear: 2000,
              maximumYear: 2100,
              onDateTimeChanged: (val) {
                tmpDate = val;
              },
            ),
          ),

          // Close the modal
          CupertinoButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(tmpDate),
          ),
          CupertinoButton(
            child: const Text(AppStrings.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
