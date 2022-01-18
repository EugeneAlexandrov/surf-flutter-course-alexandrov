import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/intention.dart';
import 'package:places/styles.dart';

import '../../colors.dart';

class PlannedSightCard extends StatelessWidget {
  const PlannedSightCard({required Intention intention, Key? key})
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Text(
                  _intention.sight.name,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(16, 2, 16, 0),
                  child: Text(
                      AppStrings.plannedCardGoalString +
                          getDate(_intention.date),
                      style: small.copyWith(color: getColor(_intention.date)))),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Text(_intention.sight.details,
                    style: small.copyWith(color: lmSecondaryColor2)),
              ),
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
                Image.asset(AppStrings.iconCalendarPath),
                const SizedBox(width: 22),
                Image.asset(AppStrings.iconCrossPath),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color getColor(DateTime date) {
    return (date.isAfter(DateTime.now())) ? Colors.green : Colors.red;
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
              image: ExactAssetImage(AppStrings.mockImageCardPath)),
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
