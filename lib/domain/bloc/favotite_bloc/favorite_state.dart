import 'package:equatable/equatable.dart';
import 'package:places/domain/model/intention.dart';

sealed class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FavoriteLoadInProgressState extends FavoriteState {}

final class FavoriteLoadSuccessState extends FavoriteState {
  final List<Intention> favoriteList;
  FavoriteLoadSuccessState(this.favoriteList);
}

final class FavoriteChangeDateState extends FavoriteState {}

final class FavoriteEmptyListState extends FavoriteState {}

final class ErrorState extends FavoriteState {}
