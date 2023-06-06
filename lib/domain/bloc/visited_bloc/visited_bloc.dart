import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/repository/intention_repository/intention_reposotory.dart';
import 'package:places/domain/bloc/visited_bloc/visited_event.dart';
import 'package:places/domain/bloc/visited_bloc/visited_state.dart';

class VisitedBloc extends Bloc<VisitedEvent, VisitedState> {
  final IntentionRepository repository;

  VisitedBloc(this.repository) : super(VisitedLoadInProgressState()) {
    on<AddToVisitedEvent>((event, emit) {
      log('AddVisitedEvent');
      emit(VisitedLoadInProgressState());
      repository.addIntentionToVisited(event.intention);
      emit(VisitedLoadSuccessState(repository.visitedPlaces));
    });
    on<RemoveFromVisitedEvent>((event, emit) {
      log('RemoveVisitedEvent');
      emit(VisitedLoadInProgressState());
      repository.removeIntentionFromFavorite(event.intention);
      emit(VisitedLoadSuccessState(repository.favoritePlaces));
    });
    on<LoadVisitedEvent>((event, emit) {
      log('LoadVisitedEvent');
      emit(VisitedLoadInProgressState());
      if (repository.visitedPlaces.isEmpty) {
        emit(VisitedEmptyListState());
      } else {
        emit(VisitedLoadSuccessState(repository.visitedPlaces));
      }
    });
    on<SwapItemsEvent>((event, emit) {
      log('SwapItemsEvent');
      repository.visitedPlaces = event.list;
      emit(VisitedLoadSuccessState(event.list));
    });
  }

  @override
  void onChange(Change<VisitedState> change) {
    super.onChange(change);
    log('${change}');
  }
}
