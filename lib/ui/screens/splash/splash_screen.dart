import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/ui/screens/splash/splash_state.getx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // state controller
  final SplashStateController _stateController =
      AppDependencyManager.getController();

  @override
  void initState() {
    super.initState();
    _stateController.initState();
  }

  @override
  void dispose() {
    _stateController.clearState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),

              Icon(
                Icons.flutter_dash_rounded,
                size: 140,
                color: Colors.blueAccent,
              ),
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
}
