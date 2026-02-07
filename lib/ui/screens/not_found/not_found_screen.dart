import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/extensions/widget_extensions.dart';
import 'package:flutter_flavors_boilerplate/app/resources/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageNotFound extends StatelessWidget {
  final String routeName;
  const PageNotFound({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PAGE NOT FOUND - 404'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(),
          Icon(
            Icons.warning_amber_rounded,
            size: 62.sp,
            color: Colors.redAccent,
          ),
          SizedBox(width: 1.sw, height: 10.h),
          Text(
            StringResource.PAGE_NOT_FOUND,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.redAccent),
          ),
          SizedBox(width: 1.sw, height: 40.h),
          Text(routeName),
          const Spacer(),
        ],
      ).padding(EdgeInsets.symmetric(horizontal: 22.w)),
    );
  }
}
