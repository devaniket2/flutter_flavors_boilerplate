import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/resources/color_resource.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/app_button.dart';
import 'package:flutter_flavors_boilerplate/ui/common_widgets/app_input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeDemoViewScreen extends StatefulWidget {
  const ThemeDemoViewScreen({super.key});

  @override
  State<ThemeDemoViewScreen> createState() => _ThemeDemoViewScreenState();
}

class _ThemeDemoViewScreenState extends State<ThemeDemoViewScreen> {
  String _selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedTheme = value;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Light',
                child: Text(
                  'Light',
                  style: TextStyle(
                    fontWeight: _selectedTheme == 'Light'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'Dark',
                child: Text(
                  'Dark',
                  style: TextStyle(
                    fontWeight: _selectedTheme == 'Dark'
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _selectedTheme == 'Light' ? LightThemeWidget() : DarkThemeWidget(),
    );
  }
}

// Light Theme Widget
class LightThemeWidget extends StatelessWidget {
  LightThemeWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // keeping colors here so on hot reload it changes instantly without needing to restart the app.
    //This is just for demo purposes, in a real app you would manage themes more globally.

    // page colors
    final Color pageBgLight = const Color(0xFFf3f3f3);
    final Color canvasColor = const Color(0xFFFAFAFA);

    return Container(
      color: pageBgLight,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Dummy Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: canvasColor,
              borderRadius: BorderRadius.circular(6.r),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  color: Colors.black.withValues(alpha: .2),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.wb_sunny, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Dummy Light Container',
                      style: TextStyle(color: Color(0xffD32F2F)),
                    ),
                    Spacer(),
                    Icon(Icons.person),
                  ],
                ),

                SizedBox(height: 8.h),

                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade200,
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Yes', style: TextStyle(color: Colors.black)),
                    ),
                    SizedBox(width: 4.w),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade200,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'APPROVE!',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    AppButton(
                      onTap: () async {},
                      child: Row(
                        children: [
                          Text('Add', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      // backgroundColor: Color(0xffe6e6e6),
                    ),
                    AppButton.icon(
                      onTap: () async {
                        _formKey.currentState?.validate();
                      },
                      flat: true,
                      backgroundColor: Colors.transparent,
                      border: Border.all(color: Colors.red, width: .8.sp),
                      icon: Icon(Icons.home_filled, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Input Field
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(color: Colors.black),

                  validator: (value) =>
                      (value?.isEmpty ?? false) ? 'Yo bitch' : null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffe6e6e6),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 12.w,
                    ),
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.black),
                        Text('Name', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    labelStyle: TextStyle(color: Colors.white70),
                    // enable border - default state
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF4f4f4f),
                        width: .6.sp,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),

                    // disable border - disable state
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .6.sp),
                      borderRadius: BorderRadius.circular(8.r),
                    ),

                    // // error border - has error, unfocused state
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red.shade300,
                        width: .6.sp,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    errorStyle: TextStyle(color: Colors.red.shade400),

                    // // focused border - focused state
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResource.PRIMARY,
                        width: .6.sp,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),

                    // // focused border - focused state
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red.shade500,
                        width: .6.sp,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                AppInputField(
                  floatingLabel: true,
                  validator: (value) =>
                      value?.isEmpty ?? false ? 'errorrrr' : null,
                  controller: TextEditingController(),
                  label: 'My sex',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Dark Theme Widget
class DarkThemeWidget extends StatelessWidget {
  DarkThemeWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Color pageBgDark = const Color(0xFF121212);

    return Container(
      color: pageBgDark,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Dummy Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border(
                right: BorderSide(color: Colors.white10, width: .5),
                top: BorderSide(color: Colors.white10, width: .5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(
                    alpha: .25,
                  ), // soft dark shadow
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF1E1E1E), // slightly lighter dark
                  Color(0xFF212121), // deep charcoal
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.nightlight_round, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Dummy Dark Container',
                      style: TextStyle(color: Color(0xffCF6679)),
                    ),
                    Spacer(),
                    Icon(Icons.person),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('Yes')),
                    Spacer(),
                    ElevatedButton(onPressed: () {}, child: Text('APPROVE!')),
                    AppButton(
                      enabled: false,
                      onTap: () async {},
                      child: Row(children: [Text('Add')]),
                      backgroundColor: Color(0xff4f4f4f),
                    ),
                    AppButton.icon(
                      onTap: () async {
                        _formKey.currentState?.validate();
                      },
                      icon: Icon(Icons.home_filled),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          // Input Field
          Form(
            key: _formKey,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),

              validator: (value) =>
                  (value?.isEmpty ?? false) ? 'Yo bitch' : null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xff242424),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 12.w,
                ),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.add), Text('Name')],
                ),
                labelStyle: TextStyle(color: Colors.white70),
                // enable border - default state
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF4f4f4f),
                    width: .6.sp,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),

                // disable border - disable state
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: .6.sp),
                  borderRadius: BorderRadius.circular(8.r),
                ),

                // // error border - has error, unfocused state
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.shade300,
                    width: .6.sp,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                errorStyle: TextStyle(color: Colors.red.shade400),

                // // focused border - focused state
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorResource.PRIMARY,
                    width: .6.sp,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),

                // // focused border - focused state
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red.shade500,
                    width: .6.sp,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
