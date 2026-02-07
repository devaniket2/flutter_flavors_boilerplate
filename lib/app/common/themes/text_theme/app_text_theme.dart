import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class AppTextTheme {
  static const TextStyle _defaultTextTheme = TextStyle(
    fontSize: 18,
    decorationStyle: TextDecorationStyle.dotted,
    fontStyle: FontStyle.italic,
  );

  // title: s, m, l
  static TextStyle titleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 18.sp) ??
      _defaultTextTheme;

  static TextStyle titleMedium(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20.sp) ??
      _defaultTextTheme;

  static TextStyle titleLarge(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22.sp) ??
      _defaultTextTheme;

  // body: s, m, l
  static TextStyle bodySmall(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp) ??
      _defaultTextTheme;

  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14.sp) ??
      _defaultTextTheme;

  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp) ??
      _defaultTextTheme;

  // display: s, m, l
  static TextStyle displaySmall(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 28.sp) ??
      _defaultTextTheme;

  static TextStyle displayMedium(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 30.sp) ??
      _defaultTextTheme;

  static TextStyle displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32.sp) ??
      _defaultTextTheme;

  // label: s, m, l
  static TextStyle labelSmall(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12.sp) ??
      _defaultTextTheme;

  static TextStyle labelMedium(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 14.sp) ??
      _defaultTextTheme;

  static TextStyle labelLarge(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16.sp) ??
      _defaultTextTheme;

  // custom text styles
  // static TextStyle bodySmall300(BuildContext context) => bodySmall(context)
  //     .copyWith(fontWeight: FontWeight.w300, color: ColorResource.LIGHT_BLACK);

  // static TextStyle bodySmall500(BuildContext context) => bodySmall(context)
  //     .copyWith(fontWeight: FontWeight.w500, color: ColorResource.LIGHT_BLACK);

  // static TextStyle bodySmall400(BuildContext context) => bodySmall(context)
  //     .copyWith(fontWeight: FontWeight.w400, color: ColorResource.LIGHT_BLACK);

  // static TextStyle labelSmall300(BuildContext context) => labelSmall(context)
  //     .copyWith(fontWeight: FontWeight.w300, color: ColorResource.LIGHT_BLACK);

  // static TextStyle labelSmall500(BuildContext context) => labelSmall(context)
  //     .copyWith(fontWeight: FontWeight.w500, color: ColorResource.LIGHT_BLACK);

  // static TextStyle labelSmall400(BuildContext context) => labelSmall(context)
  //     .copyWith(fontWeight: FontWeight.w400, color: ColorResource.LIGHT_BLACK);

  // static TextStyle titleBlue400(BuildContext context) => bodyLarge(context)
  //     .copyWith(fontWeight: FontWeight.w400, color: ColorResource.PRIMARY_BLUE);

  // static TextStyle titleBlue600(BuildContext context) => bodyLarge(context)
  //     .copyWith(fontWeight: FontWeight.w600, color: ColorResource.PRIMARY_BLUE);

  // static TextStyle titleLightBlack16(BuildContext context) =>
  //     bodyLarge(context).copyWith(
  //         fontWeight: FontWeight.w500,
  //         color: ColorResource.LIGHT_BLACK,
  //         fontSize: 16.sp);

  // static TextStyle labelXtraSmall(BuildContext context) =>
  //     labelSmall(context).copyWith(
  //         fontWeight: FontWeight.w400,
  //         color: ColorResource.LIGHT_BLACK,
  //         fontSize: 11.sp);
}
