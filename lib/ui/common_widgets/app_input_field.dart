import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputField extends StatelessWidget {
  // required
  final TextEditingController controller;

  // optional
  final String? tag; // Add a tag to identify the field
  final String? label;
  final bool floatingLabel;
  final String? value;
  final double? width;
  final double? height;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool? obscuredText;
  final FocusNode? focusNode;
  final bool textCenterAligned;
  final double? hintTextSize;
  final double? borderRadius;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final TextStyle? counterStyle;
  const AppInputField({
    super.key,
    required this.controller,
    this.tag = "",
    this.floatingLabel = false,
    this.label,
    this.value,
    this.prefix,
    this.validator,
    this.keyboardType,
    this.maxLines,
    this.textCenterAligned = false,
    this.hintTextSize,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.width,
    this.height,
    this.maxLength,
    this.counterStyle,
    this.focusNode,
    this.obscuredText,
    this.suffix,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // actual widget
    return SizedBox(
      width: width ?? .75.sw,
      height: height,
      child: TextFormField(
        controller: controller,
        initialValue: value,
        enabled: enabled,
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        obscureText: obscuredText ?? false,
        textAlign: textCenterAligned ? TextAlign.center : TextAlign.start,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        style: AppTextTheme.titleSmall(context).copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 15.sp,
        ),
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          label: floatingLabel ? Text(label ?? 'Label') : null,
          labelStyle: TextStyle(
            color: controller.text.isEmpty
                ? Colors.grey.shade800
                : ColorResource.PRIMARY_BLUE,
          ),
          prefixIcon: prefix,
          suffix: suffix,
          counterStyle: counterStyle,
          errorStyle: counterStyle,
          fillColor: (enabled) ? Colors.white : Colors.grey.shade300,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),

          // enable border - default state
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: controller.text.isEmpty
                  ? const Color(0xFFBCBCBC)
                  : ColorResource.PRIMARY_BLUE,
              width: 1.sp,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),

          // disable border - disable state
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.sp),
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),

          // error border - has error, unfocused state
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 1.sp),
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),

          // focused border - focused state
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: controller.text.isEmpty
                  ? const Color(0xFFBCBCBC)
                  : ColorResource.PRIMARY_BLUE,
              width: 1.sp,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),

          // focused border - focused state
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 1.sp),
            borderRadius: BorderRadius.circular(borderRadius ?? 30.r),
          ),

          // hints
          hintText: floatingLabel ? null : label,
          hintStyle: AppTextTheme.titleSmall(context).copyWith(
            color: const Color(0xFF656571),
            fontWeight: FontWeight.w400,
            fontSize: (hintTextSize ?? 14).sp,
          ),
        ),
      ),
    );
  }
}
