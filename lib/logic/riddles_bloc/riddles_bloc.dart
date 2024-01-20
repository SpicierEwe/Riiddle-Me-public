import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:riddle_me/data/riddles.dart';
import 'package:riddle_me/utils/audio_utils.dart';
import 'package:riddle_me/utils/general_utils.dart';
import 'package:sizer/sizer.dart';

part 'riddles_event.dart';

part 'riddles_state.dart';

class RiddlesBloc extends HydratedBloc<RiddlesEvent, RiddlesState> {
  final InAppReview _inAppReview = InAppReview.instance;

  RiddlesBloc()
      : super(RiddlesState(
            randomRiddleIndex:
                Random().nextInt(RiddlesDb.riddlesList.length))) {
    // on<NextRiddleEvent>((event, emit) async {
    //   // if (state.riddlesSeenCount >= 3) {
    //   //   Logger().i("riddlesSeenCount: ${state.riddlesSeenCount}");
    //   //   if (await _inAppReview.isAvailable()) {
    //   //     _inAppReview.requestReview();
    //   //   }
    //   // }
    //   emit(state.copyWith(
    //     randomRiddleIndex: state.randomRiddleIndex + 1,
    //     isRiddleRevealed: false,
    //     takenHints: 0,
    //     usersAvailableHints: state.totalHints,
    //     riddlesSeenCount: state.riddlesSeenCount + 1,
    //   ));
    // });

    on<NewRiddleEvent>((event, emit) {
      if (state.isRiddleRevealed) {
        emit(state.copyWith(
          randomRiddleIndex:
              Random().nextInt(RiddlesDb.riddlesList.length - 1) + 1,
          isRiddleRevealed: false,
          takenHints: 0,
          usersAvailableHints: state.totalHints,
          riddlesSeenCount: state.riddlesSeenCount + 1,
        ));
      }
    });

    on<RevealRiddleEvent>((event, emit) async {
      CustomAudioUtils().playRevealSound();
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(isRiddleRevealed: true));
    });

    on<TakeHintEvent>((event, emit) {
      if (state.usersAvailableHints > 0 && state.points > 0) {
        CustomAudioUtils().playHintSound();
        // await Future.delayed(const Duration(milliseconds: 500));
        sleep(const Duration(milliseconds: 300));
        emit(state.copyWith(
            usersAvailableHints: state.usersAvailableHints - 1,
            takenHints: state.takenHints + 1,
            points: state.points - 1));
      } else {
        CustomAudioUtils().playHintsFinishedSound();

        GeneralUtils.displayToast("no more hints available");
      }
    });

    on<InitializePointsAndUserAvailableHints>((event, emit) {
      if (state.points > 0) {
        if (state.takenHints == 0) {
          if (state.points > state.totalHints) {
            emit(state.copyWith(
              usersAvailableHints: state.totalHints,
            ));
          } else {
            emit(state.copyWith(
              usersAvailableHints: state.points,
            ));
          }
        }
      } else {
        emit(state.copyWith(
          usersAvailableHints: 0,
        ));
      }
    });

    on<UpdateEarnedPoints>((event, emit) {
      emit(state.copyWith(
        points: state.points + event.points,
      ));
    });

    on<DevToolsEvent>((event, emit) {
      emit(state.copyWith(
        points: state.points + 5,
      ));
    });
  }

  @override
  RiddlesState? fromJson(Map<String, dynamic> json) {
    return RiddlesState(
      points: json['points'] as int,
      randomRiddleIndex: json['riddleIndex'] as int,
      takenHints: json['takenHints'] as int,
      isRiddleRevealed: json['isRiddleRevealed'] as bool,
      totalHints: json['totalHints'] as int,
      usersAvailableHints: json['usersAvailableHints'] as int,
    );
  }

  @override
  Map<String, dynamic>? toJson(RiddlesState state) {
    return {
      'points': state.points,
      'riddleIndex': state.randomRiddleIndex,
      'takenHints': state.takenHints,
      'isRiddleRevealed': state.isRiddleRevealed,
      'totalHints': state.totalHints,
      'usersAvailableHints': state.usersAvailableHints,
    };
  }
}
