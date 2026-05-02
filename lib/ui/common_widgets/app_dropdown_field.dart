import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDownField<T> extends FormField<T> {
  AppDropDownField({
    super.key,
    required List<DropdownMenuItem<T>> items,
    T? value,
    String hint = 'Select',
    bool floatingLabel = true,
    super.validator,
    void Function(T?)? onChanged,
    String? errorText,
    double? width,
    double? height,
    Widget? prefix,
    Widget? suffix,
    TextStyle? counterStyle,
    double? borderRadius,
    bool enabled = true,
  }) : super(
         initialValue: value,
         builder: (FormFieldState<T> state) {
           Color? fieldFillColor;

           Color textColor = AppUtils.isDarkMode(state.context)
               ? ColorResource.TEXT_TITLE_LIGHT
               : ColorResource.TEXT_TITLE_DARK;

           Color errorColor = AppUtils.isDarkMode(state.context)
               ? const Color(0xfff27373)
               : ColorResource.ERROR_LIGHT;

           if (state.hasError) {
             fieldFillColor = AppUtils.isDarkMode(state.context)
                 ? Colors.red.shade200.withValues(alpha: .1)
                 : Colors.red.shade100.withValues(alpha: .3);
           } else if (enabled) {
             fieldFillColor = AppUtils.isDarkMode(state.context)
                 ? ColorResource.CANVAS_DARK_SECONDARY
                 : ColorResource.CANVAS_LIGHT_PRIMARY;
           } else {
             fieldFillColor = Colors.grey.shade500;
           }

           return SizedBox(
             width: width ?? .88.sw,
             height: height,
             child: DropdownButtonHideUnderline(
               child: DropdownButtonFormField<T>(
                 initialValue: state.value,
                 isExpanded: true,
                 items: items,
                 iconEnabledColor: state.hasError
                     ? errorColor
                     : AppUtils.isDarkMode(state.context)
                     ? ColorResource.TEXT_SUBTITLE_LIGHT
                     : ColorResource.CANVAS_DARK_SECONDARY,
                 onChanged: (val) {
                   state.didChange(val); // updates FormField state
                   if (onChanged != null) onChanged(val);
                 },
                 validator: validator,
                 style: AppTextTheme.bodySmall(
                   state.context,
                 ).copyWith(color: textColor),
                 menuMaxHeight: .4.sh,
                 decoration: InputDecoration(
                   label: floatingLabel ? Text(hint) : null,
                   labelStyle: AppTextTheme.bodySmall(
                     state.context,
                   ).copyWith(color: state.hasError ? errorColor : textColor),
                   prefixIcon: prefix,
                   suffix: suffix,
                   filled: true,
                   fillColor: fieldFillColor,
                   counterStyle: counterStyle ?? TextStyle(color: errorColor),
                   errorStyle: TextStyle(color: errorColor),
                   errorText: state.errorText ?? errorText, // <-- key line
                   contentPadding: EdgeInsets.symmetric(
                     vertical: 8.h,
                     horizontal: 12.w,
                   ),

                   // enable border - default state
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                       color: value == null
                           ? ColorResource.INPUT_BORDER
                           : ColorResource.PRIMARY,
                       width: .6.sp,
                     ),
                     borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                   ),

                   // disable border - disable state
                   disabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.grey, width: .6.sp),
                     borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                   ),

                   // error border - has error, unfocused state
                   errorBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: errorColor, width: .6.sp),
                     borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                   ),

                   // focused border - focused state
                   focusedBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                       color: value == null
                           ? ColorResource.TEXT_SUBTITLE_LIGHT
                           : ColorResource.PRIMARY,
                       width: .6.sp,
                     ),
                     borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                   ),

                   // focused border - focused state
                   focusedErrorBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: errorColor, width: .6.sp),
                     borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                   ),
                 ),
               ),
             ),
           );
         },
       );
}
