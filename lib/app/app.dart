import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/theme.state.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/theme_manager.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlavorBoilerplateApp extends StatefulWidget with WidgetsBindingObserver {
  FlavorBoilerplateApp({super.key});

  @override
  State<FlavorBoilerplateApp> createState() => _FlavorBoilerplateAppState();
}

class _FlavorBoilerplateAppState extends State<FlavorBoilerplateApp> {
  final ThemeManager _themeManager = ThemeManager();

  // listener for brigthness
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _onChangePlatformBrightess(MediaQuery.platformBrightnessOf(context));
  }

  void _onChangePlatformBrightess(Brightness brigthness) {
    _themeManager.changeThemeOnBrightnessChange(brigthness);
  }

  @override
  void dispose() {
    _themeManager.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 823), // Pixel 2 XL size reference
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        // bloc builder
        return BlocProvider.value(
          value: _themeManager,
          child: BlocBuilder<ThemeManager, ThemeState>(
            builder: (context, state) => MaterialApp(
              navigatorKey: GlobalContextKey.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: StringResource.APP_TITLE,
              theme: state.themeData,
              onGenerateRoute: AppNavigator.getRoutes,
              initialRoute: Screens.SPLASH_SCREEN,
            ),
          ),
        );
      },
    );
  }
}
