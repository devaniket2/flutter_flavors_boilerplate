import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/app_container.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/primary_app_bar/primary_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'Dynamic Widget Test'),
      body: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12.h),

                _largeContainer(),

                SizedBox(height: 12.h),

                _horizontalContainerList(),

                SizedBox(height: 12.h),

                _gridView(),

                SizedBox(height: 12.h),

                _largeCard(),

                SizedBox(height: 12.h),

                _buttons(),

                SizedBox(height: 12.h),

                _icons(),

                SizedBox(height: 12.h),

                _radioButtons(),

                SizedBox(height: 12.h),

                _checkboxes(),

                SizedBox(height: 12.h),

                _inputField(),

                SizedBox(height: 12.h),

                _loadingIndicator(),

                SizedBox(height: 12.h),

                _showDialogs(),

                SizedBox(height: 12.h),

                _bottomSheet(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _largeContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1. Large Landscape Container',
          style: AppTextTheme.titleSmall(context),
        ),

        SizedBox(height: 6.h),

        AppContainer(
          child: Container(
            // color: Colors.red,
            height: 120,
            width: 1.sw,
            child: Center(child: Text('data')),
          ),
        ),
      ],
    );
  }

  Widget _horizontalContainerList() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '2. Horizontal ListView',
            style: AppTextTheme.titleSmall(context),
          ),

          SizedBox(height: 6.h),

          // list
        ],
      ),
    );
  }

  Widget _gridView() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('3. GridView', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // gridview
        ],
      ),
    );
  }

  Widget _largeCard() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('4. Large Card', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // gridview
        ],
      ),
    );
  }

  Widget _buttons() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('5. Buttons', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _icons() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('6. Icons', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _radioButtons() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('7. Radio Buttons', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _checkboxes() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('8. CheckBox', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _inputField() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '9. Inputs Field and dropdown',
            style: AppTextTheme.titleSmall(context),
          ),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _loadingIndicator() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '10. Progress Indicators',
            style: AppTextTheme.titleSmall(context),
          ),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _showDialogs() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('11. Dialog Viewer', style: AppTextTheme.titleSmall(context)),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '12. Bottom sheet View',
            style: AppTextTheme.titleSmall(context),
          ),

          SizedBox(height: 6.h),

          // button
        ],
      ),
    );
  }
}
