import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

sealed class AppWidget {
  AppWidget._();

  static Future<void> showDialog({
    Widget? title,
    Widget? content,
    bool showCancelButton = true,
    bool dismissible = true,
    Color? cancelTextColor,
    Color? confirmTextColor,
    String? cancelText,
    String? confirmText,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) async {
    final context = GlobalContextKey.navigatorKey.currentContext!;
    final controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    await showGeneralDialog(
      context: context,
      barrierDismissible: false, // allow taps outside
      barrierLabel: 'Dialog',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SafeArea(
          child: Center(
            child: ScaleTransition(
              scale: Tween<double>(
                begin: 1.0,
                end: 1.05,
              ).chain(CurveTween(curve: Curves.elasticOut)).animate(controller),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 0.85.sw,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dialogTheme.backgroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title ?? Text('Dialog Title'),
                      SizedBox(height: 8.h),
                      content ?? Text('Dialog content here'),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (showCancelButton)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                onCancel?.call();
                              },
                              style: ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                  cancelTextColor?.withValues(alpha: .1) ??
                                      Theme.of(
                                        context,
                                      ).primaryColor.withValues(alpha: .1),
                                ),
                              ),
                              child: Text(
                                cancelText ?? 'CANCEL',
                                style: AppTextTheme.bodyMedium(context)
                                    .copyWith(
                                      color:
                                          cancelTextColor ??
                                          Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              onConfirm?.call();
                            },
                            style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll(
                                confirmTextColor?.withValues(alpha: .1) ??
                                    Theme.of(
                                      context,
                                    ).primaryColor.withValues(alpha: .1),
                              ),
                            ),
                            child: Text(
                              confirmText ?? 'OK',
                              style: AppTextTheme.bodyMedium(context).copyWith(
                                color:
                                    confirmTextColor ??
                                    Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // keep your blur + fade logic here
        final curved = Curves.easeOut.transform(animation.value);
        const double maxBlur = 6.0;
        const double maxDimOpacity = 0.30;
        final double currentBlur = maxBlur * animation.value;
        final double currentDim = maxDimOpacity * animation.value;

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  // Instead of closing, trigger bounce
                  if (dismissible) {
                    Navigator.of(context).pop();
                  } else {
                    controller.forward(from: 0.0);
                  }
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: currentBlur,
                    sigmaY: currentBlur,
                  ),
                  child: Container(color: Colors.black.withOpacity(currentDim)),
                ),
              ),
            ),
            Opacity(
              opacity: animation.value,
              child: Transform.scale(scale: 0.95 + 0.05 * curved, child: child),
            ),
          ],
        );
      },
    );
  }
}
