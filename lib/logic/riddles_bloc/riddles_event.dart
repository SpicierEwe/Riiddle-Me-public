part of 'riddles_bloc.dart';

@immutable
abstract class RiddlesEvent {}

class PreviousRiddleEvent extends RiddlesEvent {}

class RevealRiddleEvent extends RiddlesEvent {}

class TakeHintEvent extends RiddlesEvent {}

class UpdateEarnedPoints extends RiddlesEvent {
  final int points;

  UpdateEarnedPoints({required this.points});
}

class InitializePointsAndUserAvailableHints extends RiddlesEvent {}

// checks if the user has revealed the riddle before closing the app and will give a new riddle on app start
// also gives a new riddle random riddle on Next button click
class NewRiddleEvent extends RiddlesEvent {}

class DevToolsEvent extends RiddlesEvent {}
