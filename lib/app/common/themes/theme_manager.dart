import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/app_dark_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/app_light_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/theme.state.dart';

enum ThemeType { Dark, Light }

class ThemeManager extends Cubit<ThemeState> {
  ThemeManager()
    : super(
        ThemeState(
          themeData:
              PlatformDispatcher.instance.platformBrightness == Brightness.light
              ? APP_LIGHT_THEME
              : APP_DARK_THEME,
        ),
      );

  // for later use, if multiple themes are there in the app
  // final Map<ThemeType, ThemeData> _appThemes = {
  //   ThemeType.Light: APP_LIGHT_THEME,
  //   ThemeType.Dark: APP_DARK_THEME,
  // };

  /// manual theme selection
  void setTheme(ThemeData theme) {
    emit(state.copyWith(themeData: theme));
  }

  /// auto theme selection based of device theme
  void changeThemeOnBrightnessChange(Brightness b) {
    emit(
      state.copyWith(
        themeData: b == Brightness.dark ? APP_DARK_THEME : APP_LIGHT_THEME,
      ),
    );
  }
}
