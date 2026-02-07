import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/app_dark_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/app_light_theme.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

enum ThemeType { Dark, Light }

class ThemeManager extends GetxController {
  // ignore: prefer_final_fields
  Rx<ThemeData> _currentTheme =
      PlatformDispatcher.instance.platformBrightness == Brightness.light
      ? APP_LIGHT_THEME.obs
      : APP_DARK_THEME.obs;

  final Map<ThemeType, ThemeData> _appThemes = {
    ThemeType.Light: APP_LIGHT_THEME,
    ThemeType.Dark: APP_DARK_THEME,
  };

  ThemeData get theme => _currentTheme.value;
  bool get isInDarkMode => _currentTheme.value == APP_DARK_THEME;

  void setTheme(Brightness brightness) {
    _currentTheme.value = brightness == Brightness.light
        ? _appThemes[ThemeType.Light]!
        : _appThemes[ThemeType.Dark]!;
  }
}
