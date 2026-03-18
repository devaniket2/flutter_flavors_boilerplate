import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  /// wraps caller widget with padding
  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);
}

// sizebox extensions
/// Extension methods on [SizedBox] to simplify
/// creating boxes with specific width or height.
extension SizedBoxExtension on SizedBox {
  /// Creates a new [SizedBox] with the given [width].
  ///
  /// Example:
  /// ```dart
  /// SizedBox().width(20); // A SizedBox with width = 20
  /// ```
  static SizedBox width(double width) => SizedBox(width: width);

  /// Creates a new [SizedBox] with the given [height].
  ///
  /// Example:
  /// ```dart
  /// SizedBox().height(50); // A SizedBox with height = 50
  /// ```
  static SizedBox height(double height) => SizedBox(height: height);
}
