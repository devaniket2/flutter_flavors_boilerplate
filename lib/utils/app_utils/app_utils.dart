import 'package:flutter_flavors_boilerplate/utils/snackbar/snackbar_manager.dart';
import 'package:url_launcher/url_launcher.dart';

sealed class AppUtils {
  AppUtils._();

  static void launchUrlInBrowser(String? path) async {
    try {
      if (path == null || path.isEmpty) {
        SnackbarManager.showError('Link is empty');
        return;
      }

      Uri uri = Uri.parse(path);

      if (await canLaunchUrl(uri)) {
        launchUrl(uri);
      } else {
        SnackbarManager.showError('Invalid link');
      }
    } on Exception catch (e) {
      SnackbarManager.showError(e.toString());
    }
  }
}
