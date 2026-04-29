import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
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
           Color? fieldFillColor;
           if (field.hasError) {
             fieldFillColor = Colors.red.shade100.withValues(alpha: .3);
           } else if (enabled) {
             fieldFillColor = Colors.white;
           } else {
             fieldFillColor = Colors.grey.shade500;
           }

           return SizedBox(
             width: width ?? .9.sw,
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
               style: AppTextTheme.titleSmall(
                 field.context,
               ).copyWith(color: Colors.black, fontSize: 15.sp),
               keyboardType: keyboardType,
               decoration: InputDecoration(
                 label: floatingLabel ? Text(label ?? 'Label') : null,
                 labelStyle: TextStyle(
                   color: controller.text.isEmpty
                       ? Colors.grey.shade800
                       : ColorResource.PRIMARY,
                 ),
                 prefixIcon: prefix,
                 suffix: suffix,
                 counterStyle: counterStyle,
                 errorStyle: counterStyle,
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
                         ? const Color(0xFFBCBCBC)
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
                   borderSide: BorderSide(
                     color: Colors.redAccent,
                     width: .6.sp,
                   ),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),
                 focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: controller.text.isEmpty
                         ? const Color(0xFFBCBCBC)
                         : ColorResource.PRIMARY,
                     width: .6.sp,
                   ),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),
                 focusedErrorBorder: OutlineInputBorder(
                   borderSide: BorderSide(
                     color: Colors.redAccent,
                     width: .6.sp,
                   ),
                   borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
                 ),

                 hintText: floatingLabel ? null : label,
                 hintStyle: AppTextTheme.titleSmall(field.context).copyWith(
                   color: const Color(0xFF656571),
                   fontWeight: FontWeight.w400,
                   fontSize: (hintTextSize ?? 14).sp,
                 ),
               ),
             ),
           );
         },
       );
}
