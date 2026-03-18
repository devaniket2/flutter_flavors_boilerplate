import 'package:flutter/material.dart';

sealed class ColorResource {
  // primary
  static const Color PRIMARY_COLOR = Colors.teal;
  // primary accent
  // secondary color
  static const Color SECONDARY_COLOR = Colors.indigoAccent;
  // secondary accent
  // tertiary color
  // tertiary accent

  /// utility colors
  // whites
  static const Color WHITE = Color(0xffffffff);
  static const Color SEMI_WHITE = Color(0xfff8f8ff);
  // blacks
  static const Color BLACK = Color(0xff000000);
  static const Color LIGHT_BLACK = Color(0xff100c08);
  static const Color SEMI_BLACK = Color(0xff454545);
  static const Color SEMI_BLACK_BG = Color(0xff1b1b1b);
}
