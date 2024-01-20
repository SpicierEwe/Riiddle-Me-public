import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riddle_me/constants/variable_constants.dart';

class BannerAdsCustomClass {
  // TODO: replace this test ad unit with your own ad unit.
  final adUnitIdDummy = VariableConstants.bannerAdUnitId;

  /// Loads a banner ad.
  BannerAd? loadAd() {
    BannerAd bannerAd = BannerAd(
      adUnitId: adUnitIdDummy,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          debugPrint('Ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load: $err');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();

    return bannerAd;
  }
}
