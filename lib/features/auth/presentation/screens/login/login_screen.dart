import 'package:flutter/material.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false; // Local UI loading simulation

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate login delay
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60.h),

                  // Brand Logo Accent
                  Container(
                    padding: EdgeInsets.all(18.r),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedLockKey,
                      size: 48.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Welcome Typography
                  Text(
                    'Welcome Back',
                    style: AppTextTheme.titleMedium(
                      context,
                    )?.copyWith(fontWeight: FontWeight.bold, fontSize: 28.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Sign in to access your personal workspace.',
                    textAlign: TextAlign.center,
                    style: AppTextTheme.bodyMedium(
                      context,
                    )?.copyWith(color: Theme.of(context).hintColor),
                  ),
                  SizedBox(height: 48.h),

                  // Email Input Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      hintText: 'name@example.com',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(14.r),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedMailAtSign01,
                          size: 20.sp,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Password Input Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    enabled: !_isLoading,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(14.r),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedAccess,
                          size: 20.sp,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: HugeIcon(
                          icon: _obscurePassword
                              ? HugeIcons.strokeRoundedView
                              : HugeIcons.strokeRoundedViewOff,
                          size: 20.sp,
                          color: Theme.of(context).hintColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _isLoading ? null : () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Interactive Modern Button
                  SizedBox(
                    width: double.infinity,
                    height: 52.h,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _onLoginPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              height: 24.r,
                              width: 24.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            )
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
