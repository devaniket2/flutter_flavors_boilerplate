import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  final String lottie;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Animation<double>? controller;
  final bool? animate;
  final bool? repeat;
  final bool? reverse;
  const LottieAnimation({
    super.key,
    required this.lottie,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.controller,
    this.animate,
    this.repeat,
    this.reverse,
  });

  @override
  Widget build(BuildContext context) {
    return lottie.contains('assets') ? asset : network;
  }

  Widget get asset => Lottie.asset(
    lottie,
    width: width,
    height: height,
    fit: fit,
    animate: animate,
    repeat: repeat,
    reverse: reverse,
    errorBuilder:
        (_, __, ___) =>
            Icon(Icons.error_outline, color: Colors.red, size: width),
  );

  Widget get network => Lottie.network(
    lottie,
    width: width,
    height: height,
    fit: fit,
    animate: animate,
    repeat: repeat,
    reverse: reverse,
    errorBuilder:
        (_, __, ___) =>
            Icon(Icons.error_outline, color: Colors.red, size: width),
  );
}
