import 'package:flutter_flavors_boilerplate/features/app_webview/cubit/app_webview_cubit.dart';
import 'package:flutter_flavors_boilerplate/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_flavors_boilerplate/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_flavors_boilerplate/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/login/cubit/login_cubit.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_flavors_boilerplate/core/config/app_config.dart';
import 'package:flutter_flavors_boilerplate/core/network/api_service.dart';

sealed class AppDependencyManager {
  static final GetIt locator = GetIt.instance;

  static Future<void> setup(AppBuildEnv type) async {
    // 1. App Config service (Async registration)
    final config = await AppConfig().init(type);

    // register config as singleton
    locator.registerSingleton<AppConfig>(config);

    // 2. Api service
    locator.registerSingleton<ApiService>(ApiService());

    /////////////// repos by layer

    // authentication layer
    locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator<ApiService>()),
    );
    locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(),
    );
    // locator.registerLazySingleton<AuthRepository>(
    //   () => AuthRepositoryImpl(
    //     remoteDataSource: locator<AuthRemoteDataSource>(),
    //     localDataSource: locator<AuthLocalDataSource>(),
    //   ),
    // );
    locator.registerLazySingleton<AuthRepository>(
      () => MockAuthRepository(localDataSource: locator<AuthLocalDataSource>()),
    );

    /////////////// cubits - must use registerFactory
    locator.registerFactory<SplashCubit>(
      () => SplashCubit(locator<AuthRepository>()),
    );
    locator.registerFactory<LoginCubit>(
      () => LoginCubit(locator<AuthRepository>()),
    );
    locator.registerFactory<DashboardCubit>(
      () => DashboardCubit(locator<AuthRepository>()),
    );
    locator.registerFactory<AppWebviewCubit>(() => AppWebviewCubit());
  }

  static T dependency<T extends Object>() => locator<T>();

  // Handy getters to easily fetch services across your data layer
  static AppConfig get appConfig => locator<AppConfig>();
  static ApiService get apiService => locator<ApiService>();
}
