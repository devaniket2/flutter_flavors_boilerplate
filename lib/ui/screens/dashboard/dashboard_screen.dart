import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/primary_app_bar/primary_app_bar.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/dashboard_state.getx.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/dashboard/pages/home/home_screen.dart';
import 'package:flutter_flavors_boilerplate/ui/views/webview/app_webview.dart';
import 'package:get/state_manager.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: "About"),
      body: const Center(
        child: Text(
          "This is the About page.\nHere you can describe your app.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
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
    return Obx(
      () => Scaffold(
        appBar: _stateController.currentPage.value != 1
            ? AppBar(title: Text('FastView'))
            : null,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Drawer header
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),

              // About menu item
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context); // close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            print(notification);

            return false;
          },
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (val) => _changePage(val),
            children: [const HomeScreen(), const AppWebview()],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
