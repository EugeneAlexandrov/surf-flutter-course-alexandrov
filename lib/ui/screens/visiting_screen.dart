import 'package:flutter/material.dart';
import 'package:places/domain/repository/intention_repository.dart';
import 'package:places/ui/components/null_planed_placeholder.dart';
import 'package:places/ui/components/null_visited_placeholder.dart';
import 'package:places/ui/components/planned_sight_card.dart';
import 'package:places/ui/components/visited_sight_card.dart';
import 'package:provider/provider.dart';

//Third tab with visited places
class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<IntentionRepository>(
      builder: (context, intentionRepository, child) {
        return TabBarView(
          children: [
            intentionRepository.plannedList.isEmpty
                ? const NullPlannedPlaceHolder()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return PlannedSightCard(
                          intentionRepository.plannedList[index].sightId);
                    },
                    itemCount: intentionRepository.plannedList.length,
                  ),
            intentionRepository.visitedList.isEmpty
                ? const NullVisitedPlaceHolder()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return VisitedSightCard(
                          intentionRepository.visitedList[index].sightId);
                    },
                    itemCount: intentionRepository.visitedList.length,
                  ),
          ],
        );
      },
    );
  }
}
