import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final Color? background;
  final double? elevation;
  final double? radius;
  final List<BoxShadow>? boxShadow;
  final Offset? shadowOffset;
  final EdgeInsets? boxPadding;
  const AppContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.background,
    this.radius,
    this.boxShadow,
    this.shadowOffset,
    this.boxPadding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: boxPadding,
      decoration: BoxDecoration(
        color: background ?? Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(radius ?? 12.r),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: elevation ?? .2),
                offset: shadowOffset ?? const Offset(0, 2),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 12.r),
        child: child,
      ),
    );
  }
}
