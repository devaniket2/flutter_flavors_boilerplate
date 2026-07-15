import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/extensions/widget_extensions.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/widgets/primary_app_bar.dart';
import 'package:flutter_flavors_boilerplate/app/resources/string_resource.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class PageNotFound extends StatelessWidget {
  final String routeName;
  const PageNotFound({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'Unknown Page'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          HugeIcon(
            icon: HugeIcons.strokeRoundedAlert02,
            size: 62.sp,
            color: Colors.redAccent,
          ),
          SizedBox(width: 1.sw, height: 12.h),
          Text(
            StringResource.PAGE_NOT_FOUND,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(color: Colors.redAccent),
          ),
          SizedBox(width: 1.sw, height: 40.h),
          Text(routeName, style: AppTextTheme.bodyMedium(context)),
          const Spacer(),
        ],
      ).padding(EdgeInsets.symmetric(horizontal: 22.w)),
    );
  }
}
