import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),

              Icon(Icons.flutter_dash_rounded, size: 140),
              Text(
                'Welcome aboard!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),

              const Spacer(),

              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void _redirect() async {
    await Future.delayed(const Duration(seconds: 1));
    AppNavigator.navigateTo(Screens.DASHBOARD, mode: AppNavigationMode.START);
  }
}
