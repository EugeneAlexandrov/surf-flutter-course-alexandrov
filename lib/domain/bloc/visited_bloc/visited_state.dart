import 'package:equatable/equatable.dart';
import 'package:places/domain/model/intention.dart';

sealed class VisitedState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class VisitedLoadInProgressState extends VisitedState {}

final class VisitedLoadSuccessState extends VisitedState {
  final List<Intention> visitedList;
  VisitedLoadSuccessState(this.visitedList);
  @override
  List<Object?> get props => [visitedList];
}

final class VisitedEmptyListState extends VisitedState {}

final class ErrorState extends VisitedState {}
