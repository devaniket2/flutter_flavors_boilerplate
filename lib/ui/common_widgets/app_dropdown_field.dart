import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPrimaryDropDownField<T> extends StatefulWidget {
  final List<DropdownMenuItem<T?>>? items;
  final bool floatingLabel;
  final T? value;
  final Widget? hint;
  final void Function(dynamic)? onChanged;
  final String? Function(dynamic)? fieldValidator;
  final String? errorText;
  final double? width;
  final double? height;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? counterStyle;
  final double? borderRadius;
  const AppPrimaryDropDownField({
    super.key,
    required this.items,
    this.floatingLabel = false,
    this.errorText,
    this.prefix,
    this.width,
    this.counterStyle,
    this.height,
    this.suffix,
    this.hint,
    this.value,
    this.fieldValidator,
    this.borderRadius,
    required this.onChanged,
  });

  @override
  State<AppPrimaryDropDownField> createState() =>
      _AppPrimaryDropDownFieldState();
}

class _AppPrimaryDropDownFieldState extends State<AppPrimaryDropDownField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? .75.sw,
      height: widget.height,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          value: widget.value,
          isExpanded: true,
          hint: widget.floatingLabel ? null : widget.hint,
          items: widget.items,
          validator: (value) {
            if (value == null) {
              return widget.errorText ?? 'Please select a value';
            }

            return null;
          },
          style: AppTextTheme.titleSmall(context).copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            label: widget.floatingLabel ? widget.hint : null,
            labelStyle: TextStyle(
              color: widget.value == null
                  ? Colors.grey.shade800
                  : ColorResource.PRIMARY_BLUE,
            ),
            prefixIcon: widget.prefix,
            suffix: widget.suffix,
            filled: true,
            fillColor: Colors.white,
            counterStyle: widget.counterStyle,
            errorStyle: widget.counterStyle,
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 12.w,
            ),

            // enable border - default state
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.value == null
                    ? const Color(0xFFBCBCBC)
                    : ColorResource.PRIMARY_BLUE,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.r),
            ),

            // disable border - disable state
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1.sp),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.r),
            ),

            // error border - has error, unfocused state
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 1.sp),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.r),
            ),

            // focused border - focused state
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.value == null
                    ? const Color(0xFFBCBCBC)
                    : ColorResource.PRIMARY_BLUE,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.r),
            ),

            // focused border - focused state
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent, width: 1.sp),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.r),
            ),

            // hints
            hintStyle: AppTextTheme.titleSmall(context).copyWith(
              color: const Color(0xFF656571),
              fontWeight: FontWeight.w400,
              fontSize: (14).sp,
            ),
          ),
        ),
      ),
    );
  }
}
