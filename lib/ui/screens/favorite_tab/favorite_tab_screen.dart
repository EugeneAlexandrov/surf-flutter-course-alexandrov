import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/app_strings.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_bloc.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_state.dart';
import 'package:places/domain/bloc/visited_bloc/visited_bloc.dart';
import 'package:places/domain/bloc/visited_bloc/visited_state.dart';
import 'package:places/ui/components/custom_appbars.dart';
import 'package:places/ui/components/null_planed_placeholder.dart';
import 'package:places/ui/components/null_visited_placeholder.dart';
import 'package:places/ui/components/planned_place_card.dart';
import 'package:places/ui/components/visited_place_card.dart';

//Third tab with visited places
class FavoriteTabScreen extends StatelessWidget {
  const FavoriteTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TabsAppBar(AppStrings.appBarTitleFavoriteString),
      body: TabBarView(
        children: [
          FavoriteList(),
          VisitedList(),
        ],
      ),
    );
  }
}

class VisitedList extends StatelessWidget {
  const VisitedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitedBloc, VisitedState>(builder: (context, state) {
      if (state is VisitedLoadInProgressState) {
        log('state is Loading', name: 'VisitedListTab');
        return const Center(child: CircularProgressIndicator());
      } else if (state is VisitedEmptyListState) {
        log('state is Empty', name: 'VisitedListTab');
        return const NullVisitedPlaceHolder();
      } else if (state is VisitedLoadSuccessState) {
        log('state is Loaded', name: 'VisitedListTab');
        final list = state.visitedList;
        return ListView.builder(
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return VisitedPlaceCard(list[index].placeId);
          },
          itemCount: list.length,
        );
      } else {
        return const Center(child: Text('Something wrong'));
      }
    });
  }
}

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavoriteLoadInProgressState) {
        log('state is Loading', name: 'FavoriteListTab');
        return const Center(child: CircularProgressIndicator());
      } else if (state is FavoriteEmptyListState) {
        log('state is Empty', name: 'FavoriteListTab');
        return const NullPlannedPlaceHolder();
      } else if (state is FavoriteLoadSuccessState) {
        log('state is Loaded', name: 'FavoriteListTab');
        final list = state.favoriteList;
        return ListView.builder(
          padding: const EdgeInsets.only(top: 8),
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return PlannedPlaceCard(list[index].placeId,
                key: Key('${list[index].placeId}'));
          },
          itemCount: list.length,
          // implemnet reorder
          // onReorder: (int oldIndex, int newIndex) {
          //   print('reoder oldIndex:$oldIndex newIndex:$newIndex');
          //   if (oldIndex < newIndex) {
          //     newIndex -= 1;
          //   }
          //   final Intention item = list.removeAt(oldIndex);
          //   list.insert(newIndex, item);
          //   BlocProvider.of<FavoriteBloc>(context).add(SwapItemsEvent(list));
          // },
        );
      } else {
        return const Center(child: Text('Something wrong'));
      }
    });
  }
}
