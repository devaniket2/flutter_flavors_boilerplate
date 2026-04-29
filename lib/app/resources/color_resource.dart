import 'package:flutter/material.dart';

sealed class ColorResource {
  // primary
  static const Color PRIMARY = Colors.teal;
  // secondary color
  static const Color SECONDARY = Colors.indigoAccent;
  // accent accent
  static const Color ACCENT = Colors.purpleAccent;

  // components colors
  static const SCAFFOLD_BACKGROUND_LIGHT = Color(0xFFf3f3f3);
  static const SCAFFOLD_BACKGROUND_DARK = Color(0xFF121212);

  static const CANVAS_LIGHT_PRIMARY = Color(0xFFFAFAFA);
  static const CANVAS_LIGHT_SECONDARY = Color(0xFFF0F0F0);

  static const CANVAS_DARK_PRIMARY = Color(0xFF1E1E1E);
  static const CANVAS_DARK_SECONDARY = Color(0xFF212121);

  static const ON_CANVAS_LIGHT = Color(0xffE6E6E6);
  static const ON_CANVAS_DARK = Color(0xff242424);

  static const INPUT_BORDER = Color(0xFF4f4f4f);

  // text colors
  static const TEXT_SUBTITLE_LIGHT = Color(0xff9E9E9E);
  static const TEXT_TITLE_LIGHT = Color(0xffE0E0E0);

  static const TEXT_TITLE_DARK = Color(0xff212121);
  static const TEXT_SUBTITLE_DARK = Color(0xff67707E);

  // ui presntation colors
  // Error
  static const Color ERROR_LIGHT = Color(0xFFD32F2F);
  static const Color ERROR_DARK = Color(0xFFCF6679);

  // Success
  static const Color SUCCESS_LIGHT = Color(0xFF388E3C);
  static const Color SUCCESS_DARK = Color(0xFF81C784);

  // Warning
  static const Color WARNING_LIGHT = Color(0xFFED6C02);
  static const Color WARNING_DARK = Color(0xFFFFB74D);
}
