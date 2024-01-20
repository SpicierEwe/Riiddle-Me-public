import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:riddle_me/ads/banner_ads.dart';
import 'package:riddle_me/ads/rewarded_ads.dart';
import 'package:riddle_me/utils/general_utils.dart';

import '../../ads/interstitial_ads.dart';
import '../riddles_bloc/riddles_bloc.dart';

part 'ad_event.dart';

part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  final RiddlesBloc riddlesBloc;

  AdBloc({required this.riddlesBloc}) : super(AdState()) {
    on<EarnPointsAdEvent>((event, emit) {
      GeneralUtils.displayToast("Loading Reward");
      try {
        RewardedAdsCustomClass().loadAd((RewardedAd? ad) {
          if (ad != null) {
            ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
              Logger()
                  .i('User earned reward of ${reward.amount} ${reward.type}');

              riddlesBloc
                  .add(UpdateEarnedPoints(points: reward.amount.toInt()));

              riddlesBloc.add(InitializePointsAndUserAvailableHints());
              GeneralUtils.displayToast(
                  "You earned ${reward.amount} ${reward.type}");
            });
          } else {
            GeneralUtils.displayToast("Ad failed to load");
          }
        });
      } catch (e) {
        Logger().e(e);
      }
    });

    on<DisplayBannerAdEvent>((event, emit) {
      emit(state.copyWith(bannerAd: BannerAdsCustomClass().loadAd()));
    });
    // Generate a random integer in the range [2, 4]

    on<DisplayInterstitialAdEvent>((event, emit) {
      if (state.requestedInterstitialAdCount ==
          state.randomIntToDisplayInterstitialAd - 1) {
        final int randomNumber = Random().nextInt(3) + 2;
        InterstitialAdsCustomClass().loadAd();
        emit(state.copyWith(
            requestedInterstitialAdCount: 0,
            randomIntToDisplayInterstitialAd: randomNumber));
      } else {
        emit(state.copyWith(
            requestedInterstitialAdCount:
                state.requestedInterstitialAdCount + 1));
      }
      Logger().i(
          "requestedInterstitialAdCount: ${state.requestedInterstitialAdCount} _randomNumber: ${state.randomIntToDisplayInterstitialAd}");
    });
  }
}
