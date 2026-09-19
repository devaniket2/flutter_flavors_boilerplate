import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppMaterialButton extends StatefulWidget {
  final Widget child;
  final FutureOr<void> Function()? onTap;
  final FutureOr<void> Function()? onLongPress;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final BorderSide? side;
  final Size? minimumSize;
  final bool fullWidth;

  /// Primary Constructor
  const AppMaterialButton({
    super.key,
    required this.child,
    required this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.splashColor,
    this.highlightColor,
    this.elevation,
    this.padding,
    this.borderRadius,
    this.side,
    this.minimumSize,
    this.fullWidth = false,
  });

  /// 1. Factory Constructor: Standalone Icon Button (No Label)
  factory AppMaterialButton.icon({
    Key? key,
    required Widget icon,
    required FutureOr<void> Function()? onTap,
    FutureOr<void> Function()? onLongPress,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? splashColor,
    Color? highlightColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BorderSide? side,
    double size = 48.0,
  }) {
    return AppMaterialButton(
      key: key,
      onTap: onTap,
      onLongPress: onLongPress,
      backgroundColor: backgroundColor ?? ColorResource.PRIMARY,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: elevation ?? 0.0,
      padding: padding ?? EdgeInsets.zero,
      borderRadius:
          borderRadius ?? BorderRadius.circular(size / 2), // Default circular
      side: side,
      minimumSize: Size(size, size),
      fullWidth: false,
      child: icon,
    );
  }

  /// 2. Factory Constructor: Text Button (Flat/Ghost Button)
  factory AppMaterialButton.text({
    Key? key,
    required String text,
    required FutureOr<void> Function()? onTap,
    FutureOr<void> Function()? onLongPress,
    TextStyle? textStyle,
    Color? backgroundColor = Colors.transparent,
    Color? foregroundColor = ColorResource.PRIMARY,
    Color? disabledBackgroundColor = Colors.transparent,
    Color? disabledForegroundColor,
    Color? splashColor = ColorResource.PRIMARY,
    Color? highlightColor,
    double elevation = 0.0,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BorderSide? side,
    Size? minimumSize,
    bool fullWidth = false,
  }) {
    return AppMaterialButton(
      key: key,
      onTap: onTap,
      onLongPress: onLongPress,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      splashColor: splashColor?.withValues(alpha: .06),
      highlightColor: highlightColor,
      elevation: elevation,
      padding:
          padding ??
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      side: side,
      minimumSize: minimumSize,
      fullWidth: fullWidth,
      child: Text(text, style: textStyle),
    );
  }

  /// 3. Factory Constructor: Icon + Label Button
  factory AppMaterialButton.iconLabel({
    Key? key,
    required Widget icon,
    required Widget label,
    required FutureOr<void> Function()? onTap,
    FutureOr<void> Function()? onLongPress,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    Color? splashColor,
    Color? highlightColor,
    double? elevation,
    EdgeInsetsGeometry? padding,
    BorderRadiusGeometry? borderRadius,
    BorderSide? side,
    Size? minimumSize,
    bool fullWidth = false,
    double iconSpacing = 8.0,
    Axis direction = Axis.horizontal,
  }) {
    final Widget content = direction == Axis.horizontal
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: iconSpacing),
              Flexible(child: label),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(height: iconSpacing),
              Flexible(child: label),
            ],
          );

    return AppMaterialButton(
      key: key,
      onTap: onTap,
      onLongPress: onLongPress,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      elevation: elevation,
      padding: padding,
      borderRadius: borderRadius,
      side: side,
      minimumSize: minimumSize,
      fullWidth: fullWidth,
      child: content,
    );
  }

  @override
  State<AppMaterialButton> createState() => _AppMaterialButtonState();
}

class _AppMaterialButtonState extends State<AppMaterialButton> {
  bool _isLoading = false;

  /// Helper to process both synchronous and asynchronous callbacks
  Future<void> _handleAction(FutureOr<void> Function()? action) async {
    if (action == null || _isLoading) return;

    setState(() => _isLoading = true);

    try {
      await action();
    } finally {
      // Prevents calling setState if the widget was unmounted during await
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    // Dynamic Shape & Border Configuration
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(12.r),
      side: widget.side ?? BorderSide.none,
    );

    // Material State Resolution
    final ButtonStyle style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return widget.disabledBackgroundColor ??
              theme.disabledColor.withValues(alpha: 0.12);
        }
        return widget.backgroundColor ?? theme.primaryColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return widget.disabledForegroundColor ??
              theme.disabledColor.withValues(alpha: 0.38);
        }
        return widget.foregroundColor ?? ColorResource.TEXT_TITLE_LIGHT;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed) &&
            widget.highlightColor != null) {
          return widget.highlightColor;
        }
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.hovered)) {
          return widget.splashColor?.withValues(alpha: 0.12);
        }
        return widget.splashColor;
      }),
      elevation: WidgetStateProperty.resolveWith<double>((states) {
        if (states.contains(WidgetState.disabled)) return 0.0;
        final baseElevation = widget.elevation ?? 2.0;
        if (states.contains(WidgetState.pressed) && baseElevation > 0) {
          return baseElevation + 2.0;
        }
        return baseElevation;
      }),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
        widget.padding ??
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(shape),
      minimumSize: WidgetStateProperty.all<Size?>(
        widget.fullWidth
            ? Size(double.infinity, widget.minimumSize?.height ?? 48.0)
            : widget.minimumSize,
      ),
    );

    return ElevatedButton(
      // Pass null when loading to visually disable action triggers
      onPressed: widget.onTap != null && !_isLoading
          ? () => _handleAction(widget.onTap)
          : null,
      onLongPress: widget.onLongPress != null && !_isLoading
          ? () => _handleAction(widget.onLongPress)
          : null,
      style: style,
      child: _isLoading
          ? SizedBox(
              height: 20.r,
              width: 20.r,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                // Automatically inherits text/icon color or white
                color: widget.foregroundColor ?? ColorResource.TEXT_TITLE_LIGHT,
              ),
            )
          : widget.child,
    );
  }
}
