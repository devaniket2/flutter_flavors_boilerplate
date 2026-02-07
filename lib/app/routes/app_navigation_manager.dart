import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/not_found/not_found_screen.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/splash/splash_screen.dart';
import 'package:flutter_flavors_boilerplate/utils/logger/app_logger.dart';

enum AppNavigationMode { PUSH, START, REPLACE }

// screens
sealed class Screens {
  Screens._();

  static const String SPLASH_SCREEN = '/';
  static const String DASHBOARD = '/dashboard';
}

// Global key for app, to get access to app context from anywhere
sealed class GlobalContextKey {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

// navigation class
sealed class AppNavigator {
  // short hand method to generate a material route with given Widget
  static MaterialPageRoute<T> _buildRoute<T extends Widget>(T page) =>
      MaterialPageRoute<T>(builder: (_) => page);

  // A method for changing route
  static Future<T?> navigateTo<T extends Object>(
    String page, {
    Object? arguments,
    AppNavigationMode mode = AppNavigationMode.PUSH,
  }) async {
    // get the current screen context
    final BuildContext? context = GlobalContextKey.navigatorKey.currentContext;

    // if null do nothing and return
    if (context == null) {
      logError('Exception: can not navigate to $page. context is null');
      return null;
    }

    // handle page transition
    switch (mode) {
      case AppNavigationMode.START:
        return await Navigator.pushNamedAndRemoveUntil(
          context,
          page,
          (route) => false,
          arguments: arguments,
        );
      case AppNavigationMode.REPLACE:
        return await Navigator.pushReplacementNamed(
          context,
          page,
          arguments: arguments,
        );
      case AppNavigationMode.PUSH:
        return await Navigator.pushNamed(context, page, arguments: arguments);
    }
  }

  /// Registers all routes for the app to navigate
  ///
  /// `NOTE`: All routes must be decalred here
  static Route<dynamic> getRoutes(RouteSettings settings) {
    // args use if passed
    // final Object? args = settings.arguments;

    // map to the page name and return the correct page
    switch (settings.name) {
      case Screens.SPLASH_SCREEN:
        return _buildRoute(const SplashScreen());

      case Screens.DASHBOARD:
        return _buildRoute(const DashboardScreen());

      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _errorRoute<T extends PageRoute>(String? name) =>
      _buildRoute(PageNotFound(routeName: name ?? 'null'));
}
