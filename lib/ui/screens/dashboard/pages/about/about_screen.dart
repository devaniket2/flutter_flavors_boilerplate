import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/primary_app_bar/primary_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'About'),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const Spacer(),

              // details
              Text(AppDependencyManager.appConfig.apiBaseUrl),
              Text(
                AppDependencyManager.appConfig.appBundleID,
                textAlign: TextAlign.center,
              ),
              Text(
                '${AppDependencyManager.appConfig.appVersion}(${AppDependencyManager.appConfig.appBuildNumber})-${AppDependencyManager.appConfig.appBuildType}',
                textAlign: TextAlign.center,
              ),
              Text(
                '${AppDependencyManager.appConfig.deviceType}-${AppDependencyManager.appConfig.deviceID} ${AppDependencyManager.appConfig.deviceName}',
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
