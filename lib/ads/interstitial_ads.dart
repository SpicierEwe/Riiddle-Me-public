import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riddle_me/constants/variable_constants.dart';

class InterstitialAdsCustomClass {
  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = VariableConstants.interstitialAdUnitId;

  /// Loads an interstitial ad.
  void loadAd() {
    AdManagerInterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdManagerAdRequest(),
        adLoadCallback: AdManagerInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            ad.show();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('AdManagerInterstitialAd failed to load: $error');
          },
        ));
  }
}
