import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/core/di/app_dependency_manager.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash.state.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash_cubit.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              Icon(Icons.flutter_dash_rounded, size: 140),
              Text(
                'Welcome aboard!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
              ),

              const Spacer(),

              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) => state.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox.shrink(),
              ),

              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }
}
