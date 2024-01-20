import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:riddle_me/utils/audio_utils.dart';

part 'config_event.dart';

part 'config_state.dart';

class ConfigBloc extends HydratedBloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(const ConfigState()) {
    on<HasSeenInitialScreensEvent>((event, emit) {
      emit(state.copyWith(hasSeenInitialScreen: true));
    });

    on<RevealIconsNamesEvent>((event, emit) async {
      CustomAudioUtils().playRevealSound();
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(areIconNamesMasked: false));
    });
  }

  @override
  ConfigState? fromJson(Map<String, dynamic> json) {
    return ConfigState(
      hasSeenInitialScreen: json['hasSeenInitialScreen'],
      areIconNamesMasked: json['areIconNamesMasked'],
    );
  }

  @override
  Map<String, dynamic>? toJson(ConfigState state) {
    return {
      'hasSeenInitialScreen': state.hasSeenInitialScreen,
      'areIconNamesMasked': state.areIconNamesMasked,
    };
  }
}
