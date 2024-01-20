import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:riddle_me/utils/hints_utils.dart';
import 'package:sizer/sizer.dart';

class VariableConstants {
  static const List<Map<String, String>> riddleAdvantages = [
    {
      "titles": "Refreshes",
      "name": "Brain",
      "image": "assets/images/brain.png",
    },
    {
      "titles": "Sharpens",
      "name": "Memory",
      "image": "assets/images/memory.png",
    },
    {
      "titles": "Improves",
      "name": "Thinking",
      "image": "assets/images/logical_thinking.png",
    },
  ];

  static const String revealSoundLink = "sounds/reveal_sound.mp3";
  static const String revealButtonImageLink = "assets/images/reveal_button.png";
  static const String revealedButtonImageLink =
      "assets/images/revealed_button.png";
  static const String hintSoundLink = "sounds/hint_sound.mp3";
  static const String hintsFinishedSoundLink =
      "sounds/hints_finished_sound.mp3";

  // =========================== ad unit ids dummy ===========
  // static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';
  // static const String rewardedAdUnitId =
  //     "ca-app-pub-3940256099942544/5224354917";
  // static const String interstitialAdUnitId =
  //     "ca-app-pub-3940256099942544/8691691433";

  // =========================== ad unit ids production ===========
  static const String bannerAdUnitId = 'ca-app-pub-8158931004067807/1024332662';

  static const String interstitialAdUnitId =
      "ca-app-pub-8158931004067807/3650496007";

  static const String rewardedAdUnitId =
      "ca-app-pub-8158931004067807/7975672255";

  static const List<Map<String, dynamic>> hintsList = [
    {
      "function": HintsUtils.getWordLength,
      "color": Color(0xffFFD700),
    },
    {
      "function": HintsUtils.getFirstLetter,
      "color": Color(0xff88d4f8),
    },
    {
      "function": HintsUtils.getLastLetter,
      "color": Color(0xff3cfebe),
    },
    // OrangeRed
  ];
}
