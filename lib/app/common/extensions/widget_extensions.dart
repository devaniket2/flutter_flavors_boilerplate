import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  /// wraps caller widget with padding
  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);
}

/// Text extensions
extension TextExtension on Text {
  Text white() {
    return Text(
      data!,
      style:
          style?.copyWith(color: Colors.white) ??
          const TextStyle(color: Colors.white),
    );
  }
}
