import 'package:equatable/equatable.dart';
import 'package:places/domain/model/intention.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class AddToFavoriteEvent extends FavoriteEvent {
  final Intention intention;
  const AddToFavoriteEvent(this.intention);
  @override
  List<Object?> get props => [intention];
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  final Intention intention;
  const RemoveFromFavoriteEvent(this.intention);
  @override
  List<Object?> get props => [intention];
}

class SwapItemsEvent extends FavoriteEvent {
  final List<Intention> list;
  const SwapItemsEvent(this.list);
  @override
  List<Object?> get props => [list];
}

class ChangeDateEvent extends FavoriteEvent {
  final Intention intention;
  const ChangeDateEvent(this.intention);
}

final class LoadFavoriteEvent extends FavoriteEvent {}
