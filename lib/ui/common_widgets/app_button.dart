import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatefulWidget {
  final Function onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? shadowColor;
  final double? elevation;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Color? splashColor;
  final Widget child;
  const AppButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.shadowColor,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.splashColor,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius:
                widget.borderRadius ?? BorderRadiusGeometry.circular(4.r),
            side: widget.borderColor != null
                ? BorderSide(color: widget.borderColor!)
                : BorderSide.none,
          ),
        ),
        shadowColor: WidgetStatePropertyAll(widget.shadowColor),
        elevation: WidgetStatePropertyAll(widget.elevation),
        foregroundColor: WidgetStatePropertyAll(widget.foregroundColor),
        backgroundColor: WidgetStatePropertyAll(widget.backgroundColor),
      ),
      onPressed: () async {
        // set loading true
        setState(() {
          _isLoading = true;
        });

        await widget.onTap();

        // set loading false
        setState(() {
          _isLoading = false;
        });
      },
      child: _isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
              constraints: BoxConstraints(minHeight: 22.sp, minWidth: 22.sp),
            )
          : widget.child,
    );
  }
}
