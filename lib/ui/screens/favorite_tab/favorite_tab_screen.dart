import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/model/intention.dart';
import 'package:places/domain/place_interactor/place_interactor.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/components/null_planed_placeholder.dart';
import 'package:places/ui/components/null_visited_placeholder.dart';
import 'package:places/ui/components/planned_place_card.dart';
import 'package:places/ui/components/visited_place_card.dart';
import 'package:provider/provider.dart';

//Third tab with visited places
class FavoriteTabScreen extends StatelessWidget {
  const FavoriteTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TabsAppBar(AppStrings.appBarTitleFavoriteString),
      body: Consumer<PlaceInteractor>(
        builder: (context, placeInteractor, child) {
          return TabBarView(
            children: [
              placeInteractor.favoritePlaces.isEmpty
                  ? const NullPlannedPlaceHolder()
                  : DraggableList(placeInteractor.favoritePlaces),
              placeInteractor.visitedPlaces.isEmpty
                  ? const NullVisitedPlaceHolder()
                  : VisitedList(placeInteractor.visitedPlaces),
            ],
          );
        },
      ),
    );
  }
}

class VisitedList extends StatelessWidget {
  const VisitedList(this.list, {Key? key}) : super(key: key);

  final List<Intention> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: Platform.isAndroid
          ? const ClampingScrollPhysics()
          : const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return VisitedPlaceCard(list[index].placeId);
      },
      itemCount: list.length,
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
    return ListView.builder(
      physics: Platform.isAndroid
          ? const ClampingScrollPhysics()
          : const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return DraggableElementWidget(widget.list[index].placeId);
      },
      itemCount: widget.list.length,
    );
  }
}

class DraggableElementWidget extends StatefulWidget {
  const DraggableElementWidget(this._placeId, {Key? key}) : super(key: key);

  final int _placeId;

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
                onAccept: (data) => Provider.of<PlaceInteractor>(context,
                        listen: false)
                    .swapIntention(
                        context
                                .findAncestorStateOfType<_DraggableListState>()
                                ?.startIndex ??
                            0,
                        widget._placeId),
                builder: (context, candidateData, rejectedData) =>
                    PlannedPlaceCard(widget._placeId,
                        key: ValueKey(widget._placeId))),
        feedback:
            PlannedPlaceCard(widget._placeId, key: ValueKey(widget._placeId)),
        onDragStarted: () {
          context.findAncestorStateOfType<_DraggableListState>()?.startIndex =
              widget._placeId;
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
