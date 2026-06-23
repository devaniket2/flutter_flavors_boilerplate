import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.state.freezed.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  const factory ThemeState({required ThemeData themeData}) = _ThemeState;
}
