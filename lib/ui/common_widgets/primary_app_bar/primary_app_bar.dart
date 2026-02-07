import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSize {
  final String title;
  final Color? color;
  final TextStyle? textStyle;
  const PrimaryAppBar({
    super.key,
    required this.title,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).primaryColor,
      alignment: Alignment.bottomCenter,
      height: 68.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              SizedBox(width: 18.w),
              if (Navigator.canPop(context))
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.pop(context),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.arrow_back_ios),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: AppTextTheme.titleMedium(
                    context,
                  ).copyWith(color: ColorResource.SEMI_WHITE),
                ),
              ),
              const Spacer(),
              SizedBox(width: 18.w),
            ],
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  @override
  Widget get child => Container(color: Colors.blue);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
