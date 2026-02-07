import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/dashboard_state.getx.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/pages/about/about_screen.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/pages/home/home_screen.dart';
import 'package:get/state_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;

  // state handler
  final DashboardStateController _stateController =
      AppDependencyManager.getController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _stateController.currentPage.value,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (val) => _changePage(val),
        children: [const HomeScreen(), AboutScreen()],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) => _changePage(value),
          currentIndex: _stateController.currentPage.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_rounded),
              label: "About",
            ),
          ],
        ),
      ),
    );
  }

  void _changePage(int index) {
    _stateController.changePage(index);
    _pageController.jumpToPage(index);
  }
}
