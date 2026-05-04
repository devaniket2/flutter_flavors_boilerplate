import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/theme_manager.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final List<Widget>? actions;
  final Widget? leading;
  final double height;
  final Color? iconColor;

  const PrimaryAppBar({
    super.key,
    required this.title,
    this.backgroundColor,
    this.textStyle,
    this.actions,
    this.leading,
    this.padding,
    this.iconColor,
    this.height = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    final double topPadding = MediaQuery.of(context).padding.top;

    return Theme(
      data: AppDependencyManager.getController<ThemeManager>().theme.copyWith(
        iconTheme: IconThemeData(
          color: iconColor ?? ColorResource.ON_CANVAS_LIGHT,
        ),
      ),
      child: Container(
        color: backgroundColor ?? Theme.of(context).primaryColor,
        height: height.h + topPadding,
        padding:
            padding ??
            EdgeInsets.only(top: topPadding, left: 14.w, right: 14.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Centered title
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style:
                  textStyle ??
                  AppTextTheme.titleSmall(context).copyWith(
                    color: isDark
                        ? ColorResource.TEXT_TITLE_LIGHT
                        : ColorResource.TEXT_TITLE_DARK,
                  ),
            ),

            // Leading widget aligned left
            Align(
              alignment: Alignment.centerLeft,
              child:
                  leading ??
                  (Navigator.canPop(context)
                      ? InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_ios),
                        )
                      : const SizedBox()),
            ),

            // Actions aligned right
            if (actions != null)
              Align(
                alignment: Alignment.centerRight,
                child: Row(mainAxisSize: MainAxisSize.min, children: actions!),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
