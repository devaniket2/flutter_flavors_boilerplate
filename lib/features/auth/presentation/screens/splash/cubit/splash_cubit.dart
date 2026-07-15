import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/app/routes/app_navigation_manager.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash.state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;

  SplashCubit(this.authRepository) : super(SplashState());

  void getFirstInfoData() async {
    emit(state.copyWith(isLoading: true));

    // mocking first call
    await Future.delayed(2.seconds);

    emit(state.copyWith(isLoading: false));

    _handleRedirection();
  }

  void _handleRedirection() async {
    if (await authRepository.isLoggedin) {
      AppNavigator.navigateTo(Screens.DASHBOARD, mode: AppNavigationMode.START);
    } else {
      AppNavigator.navigateTo(
        Screens.LOGIN_SCREEN,
        mode: AppNavigationMode.START,
      );
    }
  }
}
