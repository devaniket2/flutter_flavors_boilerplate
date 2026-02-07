import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_flavors_boilerplate/utils/logger/app_logger.dart';

enum SnackbarManagerType { SUCCESS, WARNING, ERROR, STANDARD }

class _SnackBarManagerStyleFormat {
  Color snackbarColor;
  Color textColor;
  _SnackBarManagerStyleFormat(this.snackbarColor, this.textColor);
}

class SnackbarManager {
  SnackbarManager._();

  static _SnackBarManagerStyleFormat _style(SnackbarManagerType type) {
    switch (type) {
      case SnackbarManagerType.SUCCESS:
        return _SnackBarManagerStyleFormat(Colors.green, Colors.white);
      case SnackbarManagerType.WARNING:
        return _SnackBarManagerStyleFormat(Colors.orangeAccent, Colors.black);
      case SnackbarManagerType.ERROR:
        return _SnackBarManagerStyleFormat(Colors.redAccent, Colors.white);
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
          style: AppTextTheme.bodyMedium(
            context,
          ).copyWith(color: _style(type).textColor),
        ),
        behavior: SnackBarBehavior.floating,
        duration: autoDismissable
            ? const Duration(milliseconds: 2000)
            : const Duration(days: 1),
        backgroundColor: _style(type).snackbarColor,
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
