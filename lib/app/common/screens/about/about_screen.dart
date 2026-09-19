import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/widgets/primary_app_bar.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_flavors_boilerplate/core/config/app_config.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  final AppConfig _appConfig = AppDependencyManager.appConfig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'About'),
      body: SafeArea(
        child: Column(
          children: [
            // Safe horizontal spacer that spans the full width without breaking constraints
            SizedBox(width: 1.sw),
            const Spacer(flex: 2),

            // Modern, styled Brand Icon Container
            Container(
              padding: EdgeInsets.all(32.r),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAndroid,
                size: 90.sp,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 24.h),

            // App Title (Using your text theme and resources)
            Text(
              StringResource.APP_TITLE,
              style: AppTextTheme.titleMedium(
                context,
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),

            // Short, Catchy Tagline
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Text(
                'Simplifying cross-platform deployments, one robust flavor at a time.',
                textAlign: TextAlign.center,
                style: AppTextTheme.bodyMedium(
                  context,
                ).copyWith(color: Theme.of(context).hintColor),
              ),
            ),

            const Spacer(flex: 3),

            // Sleek Dummy Info Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Theme.of(context).dividerColor.withAlpha(15),
                  ),
                ),
                child: Column(
                  children: [
                    _buildInfoTile(
                      context,
                      HugeIcons.strokeRoundedBlockchain03,
                      'Version',
                      '${_appConfig.appVersion} (Build ${_appConfig.appBuildNumber})',
                    ),
                    _buildDivider(context),
                    _buildInfoTile(
                      context,
                      HugeIcons.strokeRoundedDatabase02,
                      'Environment',
                      _appConfig.appBuildType == AppBuildEnv.production
                          ? 'Production'
                          : 'QA',
                    ),
                    _buildDivider(context),
                    _buildInfoTile(
                      context,
                      HugeIcons.strokeRoundedCopyright,
                      'License',
                      'LSIC License',
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(flex: 1),

            // Footer Company Branding
            Text(
              'Developed by Aniket Nandi',
              style: AppTextTheme.bodyMedium(context).copyWith(
                color: Theme.of(context).disabledColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'V${_appConfig.appVersion}-product-global',
              style: AppTextTheme.bodyMedium(context).copyWith(
                color: Theme.of(context).disabledColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  // Helper widget to generate clean, modern metadata rows
  Widget _buildInfoTile(
    BuildContext context,
    List<List<dynamic>> icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          HugeIcon(
            icon: icon,
            size: 20.sp,
            color: Theme.of(context).primaryColor.withAlpha(200),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: AppTextTheme.bodyMedium(
              context,
            ).copyWith(color: Theme.of(context).hintColor),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextTheme.bodyMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Theme.of(context).dividerColor.withAlpha(15),
    );
  }
}
