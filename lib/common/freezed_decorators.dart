import 'package:freezed_annotation/freezed_annotation.dart';

const freezedEvent = Freezed(
  makeCollectionsUnmodifiable: true,
  addImplicitFinal: true,
  equal: true,
  toJson: false,
  fromJson: false,
  copyWith: false,
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
);

const freezedState = Freezed(
  makeCollectionsUnmodifiable: true,
  addImplicitFinal: true,
  equal: true,
  toJson: false,
  fromJson: false,
  copyWith: true,
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
);
