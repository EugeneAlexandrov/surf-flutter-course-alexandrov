import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/repository/intention_repository/intention_reposotory.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_event.dart';
import 'package:places/domain/bloc/favotite_bloc/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final IntentionRepository repository;

  FavoriteBloc(this.repository) : super(FavoriteLoadInProgressState()) {
    on<AddToFavoriteEvent>((event, emit) {
      log('AddFavoriteEvent');
      emit(FavoriteLoadInProgressState());
      repository.addIntentionToFavorite(event.intention);
      emit(FavoriteLoadSuccessState(repository.favoritePlaces));
    });
    on<RemoveFromFavoriteEvent>((event, emit) {
      log('RemoveFavoriteEvent');
      emit(FavoriteLoadInProgressState());
      repository.removeIntentionFromFavorite(event.intention);
      emit(FavoriteLoadSuccessState(repository.favoritePlaces));
    });
    on<LoadFavoriteEvent>((event, emit) {
      log('LoadFavoriteEvent');
      emit(FavoriteLoadInProgressState());
      if (repository.favoritePlaces.isEmpty) {
        emit(FavoriteEmptyListState());
      } else {
        emit(FavoriteLoadSuccessState(repository.favoritePlaces));
      }
    });
    on<ChangeDateEvent>((event, emit) {
      log('ChangeDateEvent');
      emit(FavoriteLoadInProgressState());
      final intention = event.intention;
      repository.favoritePlaces
          .firstWhere((element) => element == intention)
          .date = intention.date;
      emit(FavoriteLoadSuccessState(repository.favoritePlaces));
    });
    on<SwapItemsEvent>((event, emit) {
      log('SwapItemsEvent');
      repository.favoritePlaces = event.list;
      emit(FavoriteLoadSuccessState(event.list));
    });
  }

  @override
  void onChange(Change<FavoriteState> change) {
    super.onChange(change);
    log('${change}');
  }
}
