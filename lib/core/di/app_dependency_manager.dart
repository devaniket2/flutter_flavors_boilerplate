import 'package:get_it/get_it.dart';
import 'package:flutter_flavors_boilerplate/core/config/app_config.dart';
import 'package:flutter_flavors_boilerplate/core/network/api_service.dart';

final GetIt locator = GetIt.instance;

sealed class AppDependencyManager {
  static Future<void> setup(BuildType type) async {
    // 1. App Config service (Async registration)
    final config = await AppConfig().init(type);

    // register config as singleton
    locator.registerSingleton<AppConfig>(config);

    // 2. Api service
    locator.registerSingleton(ApiService());
  }

  // Handy getters to easily fetch services across your data layer
  static AppConfig get appConfig => locator<AppConfig>();
  static ApiService get apiService => locator<ApiService>();
}
