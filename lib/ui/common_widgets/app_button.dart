import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
import 'package:flutter_flavors_boilerplate/utils/snackbar/snackbar_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatefulWidget {
  final Future<void> Function() onTap;
  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Border? border;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Widget? loadingPlaceholder;
  final double? loaderSize;
  final bool enabled;
  final bool isIconButton;
  final bool flat;

  const AppButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.height,
    this.width,
    this.loaderSize,
    this.loadingPlaceholder,
    this.border,
    this.enabled = true,
    this.isIconButton = false,
    this.flat = false,
  });

  factory AppButton.icon({
    Key? key,
    required Icon icon,
    required Future<void> Function() onTap,
    Color? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? size,
    double? loaderSize,
    Widget? loadingPlaceholder,
    Border? border,
    bool enabled = true,
    bool flat = false,
  }) => AppButton(
    onTap: onTap,
    isIconButton: true,
    backgroundColor: backgroundColor,
    width: size,
    height: size,
    padding: padding,
    loaderSize: loaderSize,
    loadingPlaceholder: loadingPlaceholder,
    enabled: enabled,
    border: border,
    flat: flat,
    child: icon,
  );

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastEaseInToSlowEaseOut,
      ),
    );
  }

  Future<void> _handleTap() async {
    if (!widget.enabled) {
      SnackbarManager.showError('Unable to perform this action right now.');
      return;
    }

    await _controller.forward();
    await _controller.reverse();

    setState(() => _isLoading = true);

    await widget.onTap();

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          alignment: widget.isIconButton ? null : Alignment.center,
          width: widget.width,
          height: widget.height,
          padding:
              widget.padding ??
              EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
          decoration: _buildDecoration(),
          child: _isLoading
              ? widget.loadingPlaceholder ??
                    SizedBox(
                      width: widget.loaderSize ?? 18.sp,
                      height: widget.loaderSize ?? 18.sp,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      ),
                    )
              : widget.child,
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      boxShadow: boxShadow,
      border: widget.border,
      shape: widget.isIconButton ? BoxShape.circle : BoxShape.rectangle,
      color: buttonColor,
      borderRadius: widget.isIconButton
          ? null
          : (widget.borderRadius ?? BorderRadius.circular(6.r)),
    );
  }

  Color get buttonColor {
    if (widget.enabled) {
      return widget.backgroundColor ?? ColorResource.PRIMARY;
    } else {
      return Colors.grey.shade500;
    }
  }

  List<BoxShadow>? get boxShadow {
    if (widget.flat) {
      return null;
    } else {
      return AppUtils.isDarkMode(context)
          ? null
          : [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black.withValues(alpha: .12),
                spreadRadius: 0,
                blurRadius: 6,
              ),
            ];
    }
  }
}
