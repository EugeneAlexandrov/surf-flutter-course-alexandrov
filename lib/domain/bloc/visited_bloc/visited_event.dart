import 'package:equatable/equatable.dart';
import 'package:places/domain/model/intention.dart';

sealed class VisitedEvent extends Equatable {
  const VisitedEvent();

  @override
  List<Object?> get props => [];
}

class AddToVisitedEvent extends VisitedEvent {
  final Intention intention;
  const AddToVisitedEvent(this.intention);
  @override
  List<Object?> get props => [intention];
}

class RemoveFromVisitedEvent extends VisitedEvent {
  final Intention intention;
  const RemoveFromVisitedEvent(this.intention);
  @override
  List<Object?> get props => [intention];
}

class SwapItemsEvent extends VisitedEvent {
  final List<Intention> list;
  const SwapItemsEvent(this.list);
  @override
  List<Object?> get props => [list];
}

final class LoadVisitedEvent extends VisitedEvent {}
