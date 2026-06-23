import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAutoCompleteField<T extends Object> extends StatelessWidget {
  final String hint;
  final String? Function(T?)? validator;
  final void Function(T)? onSelected;
  final double? borderRadius;
  final String Function(T) displayStringForOption;
  final Widget Function(BuildContext, void Function(T), Iterable<T>)?
  optionsViewBuilder;
  final bool enable;
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  final double? width;
  final double? height;
  final Color? hintColor;
  const AppAutoCompleteField({
    super.key,
    this.borderRadius,
    this.validator,
    required this.hint,
    required this.optionsBuilder,
    this.optionsViewBuilder,
    this.onSelected,
    required this.displayStringForOption,
    this.enable = true,
    this.width,
    this.height,
    this.hintColor,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      enabled: enable,
      builder: (state) {
        Color? fieldFillColor;

        if (state.hasError) {
          fieldFillColor = AppUtils.isDarkMode(context)
              ? Colors.red.shade200.withValues(alpha: .1)
              : Colors.red.shade100.withValues(alpha: .3);
        } else if (enable) {
          fieldFillColor = AppUtils.isDarkMode(context)
              ? ColorResource.CANVAS_DARK_SECONDARY
              : ColorResource.CANVAS_LIGHT_PRIMARY;
        } else {
          fieldFillColor = Colors.grey.shade500;
        }

        Color errorColor = AppUtils.isDarkMode(context)
            ? Color(0xfff27373)
            : ColorResource.ERROR_LIGHT;

        Color borderColor = ColorResource.INPUT_BORDER;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Autocomplete<T>(
              displayStringForOption: displayStringForOption,
              onSelected: onSelected,
              optionsBuilder: optionsBuilder,
              optionsViewBuilder: optionsViewBuilder,
              fieldViewBuilder:
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return SizedBox(
                      width: width ?? .88.sw,
                      height: height,
                      child: TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onFieldSubmitted: (value) => onFieldSubmitted,
                        decoration: InputDecoration(
                          errorText: state.errorText,
                          filled: true,
                          fillColor: fieldFillColor,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 12.w,
                          ),
                          hintText: hint,
                          hintStyle: AppTextTheme.bodySmall(context).copyWith(
                            color: state.hasError
                                ? errorColor
                                : (hintColor ??
                                      ColorResource.TEXT_SUBTITLE_LIGHT),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textEditingController.text.isEmpty
                                  ? borderColor
                                  : ColorResource.PRIMARY,
                              width: .6.sp,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius ?? 8.r,
                            ),
                          ),

                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: .6.sp,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius ?? 8.r,
                            ),
                          ),

                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorColor,
                              width: .6.sp,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius ?? 8.r,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: textEditingController.text.isEmpty
                                  ? (AppUtils.isDarkMode(context)
                                        ? ColorResource.TEXT_SUBTITLE_LIGHT
                                        : ColorResource.TEXT_TITLE_DARK)
                                  : ColorResource.PRIMARY,
                              width: .6.sp,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius ?? 8.r,
                            ),
                          ),

                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: errorColor,
                              width: .6.sp,
                            ),
                            borderRadius: BorderRadius.circular(
                              borderRadius ?? 8.r,
                            ),
                          ),

                          counterStyle: TextStyle(color: errorColor),
                          errorStyle: TextStyle(color: errorColor),
                        ),
                      ),
                    );
                  },
            ),

            // if (state.hasError) SizedBox(height: 3.h),
            // if (state.hasError)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 14),
            //     child: Text(
            //       state.errorText ?? 'Can not be empty',
            //       style: AppTextTheme.labelSmall(
            //         context,
            //       ).copyWith(color: errorColor),
            //     ),
            //   ),
          ],
        );
      },
    );
  }
}
