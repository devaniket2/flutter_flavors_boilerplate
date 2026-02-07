import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SplashStateController extends GetxController {
  void initState() {
    _redirect();
  }

  void _redirect() async {
    await Future.delayed(const Duration(seconds: 1));
    AppNavigator.navigateTo(Screens.DASHBOARD, mode: AppNavigationMode.START);
  }

  void clearState() {}
}
