import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/extensions/widget_extensions.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/app_button.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/app_container.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/app_gradient_text.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/primary_app_bar/primary_app_bar.dart';
import 'package:flutter_flavors_boilerplate/utils/app_utils/app_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedRadio;
  bool _checked = false;
  String? _dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(title: 'Dynamic Widget Test'),
      body: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
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
            width: 1.sw,
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  "Body Large",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "Body Medium",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Body Small",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 12),
                Text(
                  "Title Large",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Title Medium",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "Title Small",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 12),
                Text(
                  "Display Large",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "Display Medium",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  "Display Small",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 12),
                Text(
                  "Label Large",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  "Label Medium",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  "Label Small",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                AppGradientText(
                  text: 'Click Me!',
                  fontSize: 31.sp,
                  gradient: LinearGradient(
                    colors: [Colors.redAccent, Colors.blueAccent],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _horizontalContainerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('2. Horizontal ListView', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (_, index) => AppContainer(
              child: Container(
                width: 120.w,
                alignment: Alignment.center,
                child: Text('Item $index'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _gridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('3. GridView', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        GridView.builder(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
          ),
          itemBuilder: (_, index) =>
              AppContainer(child: Center(child: Text('Grid $index'))),
        ),
      ],
    );
  }

  Widget _largeCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('4. Large Card', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Title', style: AppTextTheme.titleMedium(context)),
                SizedBox(height: 8.h),
                Text('This is a large card with some descriptive text.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('5. Buttons', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        AppButton(
          onTap: () async {
            await Future.delayed(const Duration(seconds: 2));
            print('done waiting');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(FontAwesomeIcons.person),
              SizedBoxExtension.width(6.w),
              Text('Get Access'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _icons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('6. Icons', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FaIcon(FontAwesomeIcons.home),
            FaIcon(FontAwesomeIcons.user),
            FaIcon(FontAwesomeIcons.cog),
          ],
        ),
      ],
    );
  }

  Widget _radioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('7. Radio Buttons', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        Row(
          children: [
            Radio<int>(
              value: 1,
              groupValue: _selectedRadio,
              onChanged: (val) => setState(() => _selectedRadio = val),
            ),
            Text('Option 1'),
            Radio<int>(
              value: 2,
              groupValue: _selectedRadio,
              onChanged: (val) => setState(() => _selectedRadio = val),
            ),
            Text('Option 2'),
          ],
        ),
      ],
    );
  }

  Widget _checkboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('8. CheckBox', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        CheckboxListTile(
          title: Text('Accept Terms'),
          value: _checked,
          onChanged: (val) => setState(() => _checked = val ?? false),
        ),
      ],
    );
  }

  Widget _inputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '9. Inputs Field and dropdown',
          style: AppTextTheme.titleSmall(context),
        ),
        SizedBox(height: 6.h),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter text',
          ),
        ),
        SizedBox(height: 12.h),
        DropdownButton<String>(
          value: _dropdownValue,
          hint: Text('Select option'),
          items: [
            'One',
            'Two',
            'Three',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (val) => setState(() => _dropdownValue = val),
        ),
      ],
    );
  }

  Widget _loadingIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '10. Progress Indicators',
          style: AppTextTheme.titleSmall(context),
        ),
        SizedBox(height: 6.h),
        LinearProgressIndicator(),
        SizedBox(height: 12.h),
        CircularProgressIndicator(),
      ],
    );
  }

  Widget _showDialogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('11. Dialog Viewer', style: AppTextTheme.titleSmall(context)),
        SizedBox(height: 6.h),
        ElevatedButton(
          onPressed: () => AppWidget.showDialog(dismissible: true),
          child: Text('Show Dialog'),
        ),
      ],
    );
  }

  Widget _bottomSheet() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('12. Bottom sheet View', style: AppTextTheme.titleSmall(context)),
      SizedBox(height: 6.h),
      ElevatedButton(
        onPressed: _showBlurredBottomSheet,
        child: Text('Show Bottom Sheet'),
      ),
    ],
  );

  /// Shows a bottom sheet while blurring the background.
  void _showBlurredBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // allow custom background with blur
      barrierColor: Colors.black.withOpacity(0.25), // dim behind blur
      builder: (context) {
        // We return a full-screen Stack so we can place a BackdropFilter
        // that covers the entire screen and then align the sheet at bottom.
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Tapping outside sheet dismisses it
            Navigator.of(context).pop();
          },
          child: SizedBox(
            height: 1.sh,
            child: Stack(
              children: [
                // Full-screen blur
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                    child: Container(
                      color: Colors.black.withOpacity(
                        0,
                      ), // needed for blur to take effect
                    ),
                  ),
                ),

                // Bottom sheet content
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    // Prevent taps inside sheet from dismissing the sheet via outer GestureDetector
                    onTap: () {},
                    child: Container(
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'This is a bottom sheet',
                              style: AppTextTheme.titleMedium(context),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Background is blurred while this sheet is visible.',
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Close'),
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
