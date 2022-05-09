import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/model/intention.dart';
import 'package:places/image_paths.dart';
import 'package:places/styles.dart';
import 'package:places/ui/components/background_image_container.dart';
import 'package:places/ui/components/custom_icon_button.dart';
import 'package:places/ui/screens/res/themes.dart';

class VisitedSightCard extends StatelessWidget {
  const VisitedSightCard(this._intention, {Key? key}) : super(key: key);

  final Intention _intention;

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
                      '${_intention.sightId}' /*.name*/,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      AppStrings.visitedCardGoalString +
                          '${getDate(_intention.date)}',
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color:
                                Theme.of(context).colorScheme.smallSecondaryTwo,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${_intention.sightId}' /*.details*/,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color:
                              Theme.of(context).colorScheme.smallSecondaryTwo),
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
              '${_intention.sightId}' /*.type*/,
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
                onPressed: () {
                  print('share');
                },
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
                onPressed: () => print('delete'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? getDate(DateTime? date) {
    if (date != null) {
      initializeDateFormatting();
      final formatter = DateFormat('dd MMM yyyy', 'ru_RU');
      return formatter.format(date);
    }
    return null;
  }
}
