import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/common/widgets/primary_app_bar.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/presentation/screens/app_webview_screen.dart';
import 'package:flutter_flavors_boilerplate/features/dashboard/presentation/cubit/dashboard.state.dart';
import 'package:flutter_flavors_boilerplate/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter_flavors_boilerplate/features/dashboard/presentation/screens/pages/home_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Builder(
        builder: (innnerContext) {
          return BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              return Scaffold(
                appBar: state.currentPage != 1
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
                            MaterialPageRoute(
                              builder: (context) => const AboutPage(),
                            ),
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
                    onPageChanged: (val) => _changePage(innnerContext, val),
                    children: [const HomeScreen(), const AppWebviewScreen()],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (value) => _changePage(innnerContext, value),
                  currentIndex: state.currentPage,
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
              );
            },
          );
        },
      ),
    );
  }

  void _changePage(BuildContext context, int index) {
    context.read<DashboardCubit>().changePage(index);
    _pageController.jumpToPage(index);
  }
}
