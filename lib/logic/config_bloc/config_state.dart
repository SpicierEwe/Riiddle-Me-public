part of 'config_bloc.dart';

@immutable
class ConfigState {
  final bool hasSeenInitialScreen;
  final bool areIconNamesMasked;

  const ConfigState({
    this.hasSeenInitialScreen = false,
    this.areIconNamesMasked = true,
  });

  ConfigState copyWith({bool? hasSeenInitialScreen, bool? areIconNamesMasked}) {
    return ConfigState(
      hasSeenInitialScreen: hasSeenInitialScreen ?? this.hasSeenInitialScreen,
      areIconNamesMasked: areIconNamesMasked ?? this.areIconNamesMasked,
    );
  }
}
