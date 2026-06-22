import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AppWebviewStateController extends GetxController {
  final RxDouble _loadingPercentage = 0.0.obs;
  final RxString _title = ''.obs;
  final RxBool _canGoBack = false.obs;
  final RxBool _canGoForward = false.obs;
  final RxBool _isAppbarVisible = true.obs;
  final RxInt _scrollY = 0.obs;

  RxDouble get loadingPercentage => _loadingPercentage;
  RxString get title => _title;
  RxBool get canGoBack => _canGoBack;
  RxBool get canGoForward => _canGoForward;
  RxBool get isAppbarVisible => _isAppbarVisible;
  RxInt get scrollY => _scrollY;

  void updateLoadingPercentage(double perc) {
    _loadingPercentage.value = perc;
  }

  void updateTitle(String title) {
    _title.value = title;
  }

  void updateCanGoBack(bool value) {
    _canGoBack.value = value;
  }

  void updateCanGoFoward(bool value) {
    _canGoForward.value = value;
  }

  void updateScrollY(int y, {int? forcedValue}) {
    _scrollY.value = forcedValue ?? y;
  }
}
