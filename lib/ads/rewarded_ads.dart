// rewarded_ads.dart

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riddle_me/constants/variable_constants.dart';

class RewardedAdsCustomClass {
  final adUnitId = VariableConstants.rewardedAdUnitId;

  /// Loads a rewarded ad.
  void loadAd(void Function(RewardedAd?) onAdLoaded) {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
          onAdLoaded(null); // Pass null when ad loading fails.
        },
      ),
    );
  }
}
