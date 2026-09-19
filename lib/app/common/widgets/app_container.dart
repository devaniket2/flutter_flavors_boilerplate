import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
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
  final BoxBorder? border;
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
    this.border,
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
        color: _backgroundColor(context),
        gradient: _gradientBackground(context),
        borderRadius: BorderRadius.circular(radius ?? 12.r),
        border: AppUtils.isDarkMode(context) && border == null
            ? Border(
                right: BorderSide(color: Colors.white10, width: .5),
                top: BorderSide(color: Colors.white10, width: .5),
              )
            : border,
        boxShadow: _boxShadow(context),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 12.r),
        child: child,
      ),
    );
  }

  Color? _backgroundColor(BuildContext context) {
    if (background != null) return background!;

    if (AppUtils.isDarkMode(context)) {
      return null;
    }

    return Theme.of(context).canvasColor;
  }

  LinearGradient? _gradientBackground(BuildContext context) {
    if (AppUtils.isDarkMode(context) && background == null) {
      return const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          ColorResource.CANVAS_DARK_PRIMARY,
          ColorResource.CANVAS_DARK_SECONDARY,
        ],
      );
    } else {
      return null;
    }
  }

  List<BoxShadow> _boxShadow(BuildContext context) {
    if (boxShadow != null && (boxShadow?.isNotEmpty ?? false)) {
      return boxShadow!;
    }

    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: elevation ?? .2),
        blurRadius: 6,
        spreadRadius: 0,
        offset: shadowOffset ?? const Offset(0, 4),
      ),
    ];
  }
}
