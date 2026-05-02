import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_utils.dart';
import 'package:flutter_flavors_boilerplate/utils/logger/app_logger.dart';

enum SnackbarManagerType { SUCCESS, WARNING, ERROR, STANDARD }

class _SnackBarManagerStyleFormat {
  Color snackbarColor;
  Color textColor;
  _SnackBarManagerStyleFormat(this.snackbarColor, this.textColor);
}

class SnackbarManager {
  SnackbarManager._();

  static _SnackBarManagerStyleFormat _style(
    BuildContext context,
    SnackbarManagerType type,
  ) {
    switch (type) {
      case SnackbarManagerType.SUCCESS:
        return _SnackBarManagerStyleFormat(
          AppUtils.isDarkMode(context)
              ? ColorResource.SUCCESS_DARK
              : ColorResource.SUCCESS_LIGHT,
          Colors.white,
        );
      case SnackbarManagerType.WARNING:
        return _SnackBarManagerStyleFormat(
          AppUtils.isDarkMode(context)
              ? ColorResource.WARNING_DARK
              : ColorResource.WARNING_LIGHT,
          ColorResource.TEXT_TITLE_DARK,
        );
      case SnackbarManagerType.ERROR:
        return _SnackBarManagerStyleFormat(
          AppUtils.isDarkMode(context)
              ? ColorResource.ERROR_DARK
              : ColorResource.ERROR_LIGHT,
          Colors.white,
        );
      case SnackbarManagerType.STANDARD:
        return _SnackBarManagerStyleFormat(Colors.grey.shade800, Colors.white);
    }
  }

  static void _showSnackbar(
    String message, {
    SnackbarManagerType type = SnackbarManagerType.STANDARD,
    bool autoDismissable = true,
  }) {
    BuildContext? context = GlobalContextKey.navigatorKey.currentContext;

    if (context == null) {
      logError('Unable to show snackbar. Counld not find app context.');
      return;
    }

    // clear if any snackbar is currently is showing
    ScaffoldMessenger.of(context).clearSnackBars();

    // display the current snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: AppTextTheme.bodySmall(
            context,
          ).copyWith(color: _style(context, type).textColor),
        ),
        behavior: SnackBarBehavior.floating,
        duration: autoDismissable
            ? const Duration(milliseconds: 2000)
            : const Duration(days: 1),
        backgroundColor: _style(context, type).snackbarColor,
      ),
    );
  }

  static void show(String message, {bool autoDismissable = true}) {
    _showSnackbar(message, autoDismissable: autoDismissable);
  }

  static void showSuccess(String message, {bool autoDismissable = true}) {
    _showSnackbar(
      message,
      type: SnackbarManagerType.SUCCESS,
      autoDismissable: autoDismissable,
    );
  }

  static void showWarning(String message, {bool autoDismissable = true}) {
    _showSnackbar(
      message,
      type: SnackbarManagerType.WARNING,
      autoDismissable: autoDismissable,
    );
  }

  static void showError(String message, {bool autoDismissable = true}) {
    _showSnackbar(
      message,
      type: SnackbarManagerType.ERROR,
      autoDismissable: autoDismissable,
    );
  }
}
