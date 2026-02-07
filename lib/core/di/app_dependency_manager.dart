import 'package:flutter_flavors_boilerplate/app/common/themes/theme_manager.dart';
import 'package:flutter_flavors_boilerplate/core/config/app_config.dart';
import 'package:flutter_flavors_boilerplate/core/network/api_service.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/dashboard_state.getx.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/splash/splash_state.getx.dart';
import 'package:get/get.dart';

/// A class that provides all registered view controllers and services
/// to use through dependency injection
///
/// In order to register controllers and services
/// use `setup()` async method which takes a `BuildType`
/// parameter
///
/// All view controllers and services must be decalred in `setup()` before accessing
sealed class AppDependencyManager {
  /// Registers `ViewControllers` and `Services` to use all over the
  /// app
  ///
  /// All view controllers and services must be decalred here before accessing
  static Future<void> setup(BuildType type) async {
    // theme manager
    Get.put(ThemeManager());
    // App Config service
    await Get.putAsync(() async => await AppConfig().init(type));
    // api service
    Get.put(ApiService());

    // state controllers
    Get.put(SplashStateController());
    Get.put(DashboardStateController());
  }

  /// Returns: `Type` view cntroller from `Widget Tree`
  ///
  /// `NOTE`: controller type `Type` has to be a child of `GetxController`
  ///
  /// Acts as a centralised storage access point for all `ViewControllers`
  ///
  /// Provides already registered `ViewControllers` to use in
  /// components.
  static T getController<T extends GetxController>() => Get.find<T>();

  /// Returns: `Type` Service from `Widget Tree`
  ///
  /// `NOTE`: Service type `Type` has to be a child of `GetxService`
  ///
  /// Acts as a centralised storage access point for all `Services`
  ///
  /// Provides already registered `Services` to use in
  /// components.
  static T getService<T extends GetxService>() => Get.find<T>();

  /// Returns: `Type Class` Service from `Widget Tree`
  ///
  /// Provides already registered `Classes` to use in
  /// components.
  static T get<T>() => Get.find<T>();

  /// A special getter which provides the instance of `AppConfig`
  static AppConfig get appConfig => getService<AppConfig>();

  /// Expose ApiService implementation
  static ApiService get apiService => Get.find();
}
