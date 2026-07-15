import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/common/themes/text_theme/app_text_theme.dart';
import 'package:flutter_flavors_boilerplate/app/common/widgets/app_button.dart';
import 'package:flutter_flavors_boilerplate/app/common/widgets/app_input_field.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/login/cubit/login.state.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/login/cubit/login_cubit.dart';
import 'package:flutter_flavors_boilerplate/utils/snackbar/snackbar_manager.dart';
import 'package:flutter_flavors_boilerplate/utils/validations/validations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppDependencyManager.dependency<LoginCubit>(),
      child: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      await context.read<LoginCubit>().login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.error != null) {
            SnackbarManager.showError(state.error ?? '');
          }

          if (state.isLoginDone) {
            AppNavigator.navigateTo(
              Screens.DASHBOARD,
              mode: AppNavigationMode.START,
            );
          }
        },
        child: SafeArea(
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
                      color: Theme.of(context).primaryColor.withAlpha(20),
                      shape: BoxShape.circle,
                    ),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedLockKey,
                      size: 48.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Welcome Typography
                  Text(
                    'Welcome Back',
                    style: AppTextTheme.titleMedium(
                      context,
                    ).copyWith(fontWeight: FontWeight.bold, fontSize: 28.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Sign in to access your personal workspace.',
                    textAlign: TextAlign.center,
                    style: AppTextTheme.bodyMedium(
                      context,
                    ).copyWith(color: Theme.of(context).hintColor),
                  ),
                  SizedBox(height: 48.h),

                  // Email Input Field
                  AppInputField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefix: Padding(
                      padding: EdgeInsets.all(14.r),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedMailAtSign01,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!Validations.isValidEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Password Input Field
                  AppInputField(
                    controller: _passwordController,
                    obscuredText: !_obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    label: 'Password',
                    prefix: Padding(
                      padding: EdgeInsets.all(14.r),
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedAccess,
                        color: Theme.of(context).hintColor,
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
                    suffix: IconButton(
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
                  ),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: null,
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
                  BlocSelector<LoginCubit, LoginState, bool>(
                    selector: (state) => state.isLoading,
                    builder: (context, isLoading) {
                      return AppButton(
                        onTap: _onLoginPressed,
                        height: 45.h,
                        child: Text(
                          'Login',
                          style: AppTextTheme.bodyLarge(context),
                        ),
                      );
                    },
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
