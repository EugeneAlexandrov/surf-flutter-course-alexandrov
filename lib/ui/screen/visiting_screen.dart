import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/intention.dart';
import 'package:places/image_paths.dart';
import 'package:places/ui/components/planned_sight_card.dart';
import 'package:places/ui/components/visited_sight_card.dart';
import 'package:places/ui/screen/res/themes.dart';

//Third tab with visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen(this.intentions, {Key? key}) : super(key: key);

  final List<Intention> intentions;

  List<Widget> get visitedList => intentions
      .where((element) => element.hasVisited)
      .map((intention) => VisitedSightCard(intention: intention))
      .toList();
  List<Widget> get plannedList => intentions
      .where((element) => !element.hasVisited)
      .map((intention) => PlannedSightCard(intention: intention))
      .toList();

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        intentions.isEmpty
            ? const NullPlannedPlaceHolder()
            : Column(children: plannedList),
        intentions.isEmpty
            ? const NullVisitedPlaceHolder()
            : Column(children: visitedList),
      ],
    );
  }
}

class NullPlannedPlaceHolder extends StatelessWidget {
  const NullPlannedPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetImages.emptyPlannedImagePath,
          height: 64,
        ),
        const SizedBox(height: 24),
        Text(AppStrings.emptyString,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.subTitle)),
        const SizedBox(height: 8),
        Text(AppStrings.nullPlannedTextString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).colorScheme.smallInnactive)),
      ],
    );
  }
}

class NullVisitedPlaceHolder extends StatelessWidget {
  const NullVisitedPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetImages.emptyVisitedImagePath, height: 64),
        const SizedBox(height: 24),
        Text(AppStrings.emptyString,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.subTitle)),
        const SizedBox(height: 8),
        Text(AppStrings.nullVisitedTextString,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: Theme.of(context).colorScheme.smallInnactive)),
      ],
    );
  }
}
