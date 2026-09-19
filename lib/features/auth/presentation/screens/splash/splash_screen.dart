import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash.state.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash_cubit.dart';
import 'package:flutter_flavors_boilerplate/utils/snackbar/snackbar_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppDependencyManager.dependency<SplashCubit>(),
      child: SplashView(),
    );
  }
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().getFirstInfoData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          AppNavigator.navigateTo(
            Screens.DASHBOARD,
            mode: AppNavigationMode.START,
          );
        } else if (state is SplashUnauthenticated) {
          AppNavigator.navigateTo(
            Screens.LOGIN_SCREEN,
            mode: AppNavigationMode.START,
          );
        } else if (state is SplashError) {
          SnackbarManager.showError(state.error, autoDismissable: false);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Icon(Icons.flutter_dash_rounded, size: 140),
                Text(
                  'Welcome aboard!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),

                const Spacer(),

                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoading) {
                      return const CircularProgressIndicator();
                    }

                    if (state is SplashLoaded) {
                      return const SizedBox.shrink();
                    }

                    return const SizedBox.shrink();
                  },
                ),

                SizedBox(height: 6.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
