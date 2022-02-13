import 'package:flutter/material.dart';
import 'package:places/domain/intention.dart';
import 'package:places/ui/components/null_planed_placeholder.dart';
import 'package:places/ui/components/null_visited_placeholder.dart';
import 'package:places/ui/components/planned_sight_card.dart';
import 'package:places/ui/components/visited_sight_card.dart';

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
