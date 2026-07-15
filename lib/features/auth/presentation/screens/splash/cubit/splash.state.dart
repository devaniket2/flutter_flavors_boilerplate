import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'splash.state.freezed.dart';

@freezed
abstract class SplashState with _$SplashState {
  const factory SplashState({@Default(false) bool isLoading}) = _SplashState;
}
