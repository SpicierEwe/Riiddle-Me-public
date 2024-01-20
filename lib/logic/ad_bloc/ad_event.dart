part of 'ad_bloc.dart';

@immutable
abstract class AdEvent {}

class EarnPointsAdEvent extends AdEvent {}

class DisplayBannerAdEvent extends AdEvent {}

class DisplayInterstitialAdEvent extends AdEvent {}
