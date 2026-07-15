import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/splash/cubit/splash.state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepository;

  SplashCubit(this.authRepository) : super(SplashInitial());

  void getFirstInfoData() async {
    emit(SplashLoading());

    try {
      // mocking first call
      await Future.delayed(3.seconds);

      // check for auth
      await _checkAuthStatus();

      emit(SplashLoaded());
    } catch (error) {
      _handleError('Could not get inital app data: ${error.toString()}');
    }
  }

  Future<void> _checkAuthStatus() async {
    if (await authRepository.isLoggedin) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashUnauthenticated());
    }
  }

  void _handleError(String error) {
    emit(SplashLoaded());
    emit(SplashError(error));
  }
}
