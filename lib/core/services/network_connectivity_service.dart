import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_flavors_boilerplate/utils/snackbar/snackbar_manager.dart';

sealed class NetworkConnectivityService {
  NetworkConnectivityService._();

  /// checks and returns whether device has a internet connection (mobile-data or wifi)
  static Future<bool> hasNetwork() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    // checks and returns whether device has a internet connection (mobile-data or wifi)
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // Mobile network available.
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // Wi-fi is available
      return true;
    } else {
      return false;
    }
  }

  /// checks whether device has wifi connection available or not
  static Future<bool> hasWiFi() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity()
        .checkConnectivity();

    return connectivityResult.contains(ConnectivityResult.wifi);
  }

  /// detects changes in network activity and returns whether device has a internet connection (mobile-data or wifi)
  static StreamSubscription<List<ConnectivityResult>> detectNetworkChanges() {
    return Connectivity().onConnectivityChanged.skip(1).listen((
      List<ConnectivityResult> result,
    ) {
      // checks and returns whether device has a internet connection (mobile-data or wifi)
      if (result.contains(ConnectivityResult.mobile)) {
        // Mobile network available.
        SnackbarManager.showSuccess('Back to Online');
      } else if (result.contains(ConnectivityResult.wifi)) {
        // Wi-fi is available
        SnackbarManager.showSuccess('Back to Online');
      } else {
        SnackbarManager.showError(
          'No Internet Connection',
          autoDismissable: false,
        );
      }
    });
  }
}
