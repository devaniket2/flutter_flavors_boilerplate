import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DashboardStateController extends GetxController {
  final RxInt _currentPage = 0.obs;

  RxInt get currentPage => _currentPage;

  void changePage(int index) {
    _currentPage.value = index;
  }
}
