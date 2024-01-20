part of 'riddles_bloc.dart';

@immutable
class RiddlesState {
  final int points;
  final int randomRiddleIndex;
  final int totalHints;

  final int riddlesSeenCount;

  final int usersAvailableHints;
  final int takenHints;
  final bool isRiddleRevealed;

  const RiddlesState({
    this.points = 5,
    this.randomRiddleIndex = 0,
    this.takenHints = 0,
    this.isRiddleRevealed = false,
    this.totalHints = 3,
    this.usersAvailableHints = 3,
    this.riddlesSeenCount = 0,
  });

  RiddlesState copyWith({
    int? points,
    int? randomRiddleIndex,
    int? totalHints,
    int? usersAvailableHints,
    bool? isRiddleRevealed,
    int? takenHints,
    int? riddlesSeenCount,
  }) {
    return RiddlesState(
      points: points ?? this.points,
      isRiddleRevealed: isRiddleRevealed ?? this.isRiddleRevealed,
      randomRiddleIndex: randomRiddleIndex ?? this.randomRiddleIndex,
      totalHints: totalHints ?? this.totalHints,
      usersAvailableHints: usersAvailableHints ?? this.usersAvailableHints,
      takenHints: takenHints ?? this.takenHints,
      riddlesSeenCount: riddlesSeenCount ?? this.riddlesSeenCount,
    );
  }
}
