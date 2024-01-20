part of 'config_bloc.dart';

@immutable
abstract class ConfigEvent {}

class HasSeenInitialScreensEvent extends ConfigEvent {}

class RevealIconsNamesEvent extends ConfigEvent {}
