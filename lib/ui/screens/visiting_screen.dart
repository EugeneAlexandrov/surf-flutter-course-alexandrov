import 'package:flutter/material.dart';
import 'package:places/domain/model/intention.dart';
import 'package:places/domain/repository/intention_repository.dart';
import 'package:places/ui/components/null_planed_placeholder.dart';
import 'package:places/ui/components/null_visited_placeholder.dart';
import 'package:places/ui/components/planned_sight_card.dart';
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
                : DraggableList(intentionRepository.plannedList),
            intentionRepository.visitedList.isEmpty
                ? const NullVisitedPlaceHolder()
                : DraggableList(intentionRepository.visitedList),
          ],
        );
      },
    );
  }
}

class DraggableList extends StatefulWidget {
  const DraggableList(this.list, {Key? key}) : super(key: key);

  final List<Intention> list;

  @override
  State<DraggableList> createState() => _DraggableListState();
}

class _DraggableListState extends State<DraggableList> {
  int? startIndex;

  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
        ? const NullPlannedPlaceHolder()
        : ListView.builder(
            itemBuilder: (context, index) {
              return DraggableElementWidget(widget.list[index].sightId);
            },
            itemCount: widget.list.length,
          );
  }
}

class DraggableElementWidget extends StatefulWidget {
  const DraggableElementWidget(this._sightId, {Key? key}) : super(key: key);

  final int _sightId;

  @override
  State<DraggableElementWidget> createState() => _DraggableElementWidgetState();
}

class _DraggableElementWidgetState extends State<DraggableElementWidget> {
  bool isDrag = false;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
        data: 'card',
        child: isDrag
            ? const SizedBox.shrink()
            : DragTarget(
                onWillAccept: (String? data) {
                  if (data == 'card') {
                    return true;
                  }
                  return false;
                },
                onAccept: (data) => Provider.of<IntentionRepository>(context,
                        listen: false)
                    .swapIntention(
                        context
                                .findAncestorStateOfType<_DraggableListState>()
                                ?.startIndex ??
                            0,
                        widget._sightId),
                builder: (context, candidateData, rejectedData) =>
                    PlannedSightCard(widget._sightId,
                        key: ValueKey(widget._sightId))),
        feedback:
            PlannedSightCard(widget._sightId, key: ValueKey(widget._sightId)),
        onDragStarted: () {
          context.findAncestorStateOfType<_DraggableListState>()?.startIndex =
              widget._sightId;
          setState(() {
            isDrag = true;
          });
        },
        onDragEnd: (details) {
          setState(() {
            isDrag = false;
          });
        });
  }
}
