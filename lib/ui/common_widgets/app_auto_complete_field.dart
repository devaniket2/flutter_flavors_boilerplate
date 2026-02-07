import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAutoCompleteField<T extends Object> extends StatelessWidget {
  final String hint;
  final String? Function(T?)? validator;
  final void Function(T)? onSelected;
  final double? borderRadius;
  final String Function(T) displayStringForOption;
  final Widget Function(BuildContext, void Function(T), Iterable<T>)?
  optionsViewBuilder;
  final FutureOr<Iterable<T>> Function(TextEditingValue) optionsBuilder;
  const AppAutoCompleteField({
    super.key,
    this.borderRadius,
    this.validator,
    required this.hint,
    required this.optionsBuilder,
    this.optionsViewBuilder,
    this.onSelected,
    required this.displayStringForOption,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      builder: (state) {
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
                    return TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onFieldSubmitted: (value) => onFieldSubmitted,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                        hintText: hint,
                        hintStyle: AppTextTheme.titleSmall(context).copyWith(
                          color: const Color(0xFF656571),
                          fontWeight: FontWeight.w400,
                          fontSize: (14).sp,
                        ),

                        // enable border - default state
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textEditingController.text.isEmpty
                                ? const Color(0xFFBCBCBC)
                                : ColorResource.PRIMARY_BLUE,
                            width: 1.sp,
                          ),
                          borderRadius: BorderRadius.circular(
                            borderRadius ?? 30.r,
                          ),
                        ),

                        // disable border - disable state
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.sp,
                          ),
                          borderRadius: BorderRadius.circular(
                            borderRadius ?? 30.r,
                          ),
                        ),

                        // error border - has error, unfocused state
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 1.sp,
                          ),
                          borderRadius: BorderRadius.circular(
                            borderRadius ?? 30.r,
                          ),
                        ),

                        // focused border - focused state
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textEditingController.text.isEmpty
                                ? const Color(0xFFBCBCBC)
                                : ColorResource.PRIMARY_BLUE,
                            width: 1.sp,
                          ),
                          borderRadius: BorderRadius.circular(
                            borderRadius ?? 30.r,
                          ),
                        ),

                        // focused border - focused state
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.redAccent,
                            width: 1.sp,
                          ),
                          borderRadius: BorderRadius.circular(
                            borderRadius ?? 30.r,
                          ),
                        ),
                      ),
                    );
                  },
            ),
            if (state.hasError) SizedBox(height: 3.h),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  state.errorText ?? 'Can not be empty',
                  style: AppTextTheme.bodySmall(
                    context,
                  ).copyWith(color: Colors.redAccent, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
