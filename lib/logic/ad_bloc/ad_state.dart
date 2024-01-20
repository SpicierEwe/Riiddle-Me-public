part of 'ad_bloc.dart';

@immutable
class AdState {
  final BannerAd? bannerAd;
  final int requestedInterstitialAdCount;
  final int randomIntToDisplayInterstitialAd;

  const AdState({
    this.bannerAd,
    this.requestedInterstitialAdCount = 0,
    this.randomIntToDisplayInterstitialAd = 2,
  });

  AdState copyWith(
      {BannerAd? bannerAd,
      int? requestedInterstitialAdCount,
      int? randomIntToDisplayInterstitialAd}) {
    return AdState(
      bannerAd: bannerAd ?? this.bannerAd,
      requestedInterstitialAdCount:
          requestedInterstitialAdCount ?? this.requestedInterstitialAdCount,
      randomIntToDisplayInterstitialAd: randomIntToDisplayInterstitialAd ??
          this.randomIntToDisplayInterstitialAd,
    );
  }
}
