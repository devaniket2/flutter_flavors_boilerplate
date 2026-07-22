import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';

class AppMaterialButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
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
    required this.onPressed,
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
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
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
      onPressed: onPressed,
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
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    TextStyle? textStyle,
    Color? backgroundColor = Colors.transparent,
    Color? foregroundColor,
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
      onPressed: onPressed,
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
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
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
      onPressed: onPressed,
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
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    bool isDarkMode = AppUtils.isDarkMode(context);

    // Dynamic Shape & Border Configuration
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(12.0),
      side: side ?? BorderSide.none,
    );

    // Material State Resolution
    final ButtonStyle style = ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledBackgroundColor ??
              theme.disabledColor.withValues(alpha: 0.12);
        }
        return backgroundColor ?? theme.primaryColor;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return disabledForegroundColor ??
              theme.disabledColor.withValues(alpha: 0.38);
        }
        return foregroundColor ??
            (isDarkMode
                ? ColorResource.TEXT_TITLE_LIGHT
                : ColorResource.TEXT_TITLE_DARK);
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed) && highlightColor != null) {
          return highlightColor;
        }
        if (states.contains(WidgetState.focused) ||
            states.contains(WidgetState.hovered)) {
          return splashColor?.withValues(alpha: 0.12);
        }
        return splashColor;
      }),
      elevation: WidgetStateProperty.resolveWith<double>((states) {
        if (states.contains(WidgetState.disabled)) return 0.0;
        final baseElevation = elevation ?? 2.0;
        if (states.contains(WidgetState.pressed) && baseElevation > 0) {
          return baseElevation + 2.0;
        }
        return baseElevation;
      }),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry?>(
        padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(shape),
      minimumSize: WidgetStateProperty.all<Size?>(
        fullWidth
            ? Size(double.infinity, minimumSize?.height ?? 48.0)
            : minimumSize,
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: style,
      child: child,
    );
  }
}
