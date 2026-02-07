import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/theme_manager.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FlavorBoilerplateApp extends StatefulWidget with WidgetsBindingObserver {
  FlavorBoilerplateApp({super.key});

  @override
  State<FlavorBoilerplateApp> createState() => _FlavorBoilerplateAppState();
}

class _FlavorBoilerplateAppState extends State<FlavorBoilerplateApp> {
  final ThemeManager themeManger =
      AppDependencyManager.getController<ThemeManager>();

  // listener for brigthness
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onChangePlatformBrightess(MediaQuery.platformBrightnessOf(context));
  }

  void _onChangePlatformBrightess(Brightness brigthness) {
    themeManger.setTheme(brigthness);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        // Obx for Theme widget observer
        return Obx(
          () => MaterialApp(
            navigatorKey: GlobalContextKey.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: '',
            theme: themeManger.theme,
            onGenerateRoute: AppNavigator.getRoutes,
            initialRoute: Screens.SPLASH_SCREEN,
          ),
        );
      },
    );
  }
}
