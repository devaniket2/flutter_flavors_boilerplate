import 'package:flutter/material.dart';

class AppGradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;

  const AppGradientText({
    super.key,
    required this.text,
    required this.gradient,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, // ignored by ShaderMask
          fontSize: fontSize ?? 16.0, // default size
          fontWeight: fontWeight ?? FontWeight.bold, // bold weight
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
