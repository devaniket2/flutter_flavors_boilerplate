import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputField extends FormField<String> {
  AppInputField({
    super.key,
    super.validator,
    // required
    required TextEditingController controller,
    // optional
    String? tag,
    String? label,
    bool floatingLabel = true,
    String? value,
    double? width,
    double? height,
    Widget? prefix,
    Widget? suffix,
    TextInputType? keyboardType,

    int? maxLines,
    int? maxLength,
    bool enabled = true,
    bool? obscuredText,
    FocusNode? focusNode,
    bool textCenterAligned = false,
    double? hintTextSize,
    double? borderRadius,
    VoidCallback? onTap,
    void Function(String)? onChanged,
    TextStyle? counterStyle,
  }) : super(
         initialValue: value ?? controller.text,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (FormFieldState<String> field) {
           bool isDarkMode = AppUtils.isDarkMode(field.context);

           Color? fieldFillColor;

           Color errorColor = isDarkMode
               ? Color(0xfff27373)
               : ColorResource.ERROR_LIGHT;

           Color textColor = isDarkMode
               ? ColorResource.TEXT_TITLE_LIGHT
               : ColorResource.TEXT_TITLE_DARK;

           Color borderColor = ColorResource.INPUT_BORDER;

           if (field.hasError) {
             fieldFillColor = isDarkMode
                 ? Colors.red.shade200.withValues(alpha: .1)
                 : Colors.red.shade100.withValues(alpha: .3);
           } else if (enabled) {
             fieldFillColor = isDarkMode
                 ? ColorResource.CANVAS_DARK_SECONDARY
                 : ColorResource.CANVAS_LIGHT_PRIMARY;
           } else {
             fieldFillColor = Colors.grey.shade500;
           }

           return SizedBox(
             width: width ?? .88.sw,
             height: height,
             child: TextField(
               controller: controller,
               enabled: enabled,
               onChanged: (val) {
                 field.didChange(val); // sync with Form
                 if (onChanged != null) onChanged(val);
               },
               onTap: onTap,
               focusNode: focusNode,
               obscureText: obscuredText ?? false,
               textAlign: textCenterAligned
                   ? TextAlign.center
                   : TextAlign.start,
               maxLines: maxLines ?? 1,
               maxLength: maxLength,
               style: AppTextTheme.bodySmall(
                 field.context,
               ).copyWith(color: field.hasError ? errorColor : textColor),
               keyboardType: keyboardType,
               decoration: InputDecoration(
                 label: floatingLabel ? Text(label ?? 'Label') : null,
                 labelStyle: TextStyle(
                   color: controller.text.isEmpty
                       ? (field.hasError ? errorColor : textColor)
                       : ColorResource.PRIMARY,
                 ),
                 prefixIcon: prefix,
                 suffix: suffix,
                 counterStyle: counterStyle ?? TextStyle(color: errorColor),
                 errorStyle: counterStyle ?? TextStyle(color: errorColor),
                 errorText: field.errorText, // <-- managed by FormField
                 fillColor: fieldFillColor,
                 filled: true,
                 contentPadding: EdgeInsets.symmetric(
                   vertical: 8.h,
                   horizontal: 12.w,
                 ),

                 enabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: controller.text.isEmpty
                         ? borderColor
                         : ColorResource.PRIMARY,
                     width: .6.sp,
                   ),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),
                 disabledBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.grey, width: .6.sp),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),
                 errorBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: errorColor, width: .6.sp),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: controller.text.isEmpty
                         ? (isDarkMode
                               ? ColorResource.TEXT_SUBTITLE_LIGHT
                               : ColorResource.TEXT_TITLE_DARK)
                         : ColorResource.PRIMARY,
                     width: .6.sp,
                   ),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),
                 focusedErrorBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: errorColor, width: .6.sp),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),

                 hintText: floatingLabel ? null : label,
                 hintStyle: AppTextTheme.titleSmall(field.context).copyWith(
                   color: const Color(0xFF656571),
                   fontWeight: FontWeight.w400,
                   //  fontSize: (hintTextSize ?? 14).sp,
                 ),
               ),
             ),
           );
         },
       );
}
