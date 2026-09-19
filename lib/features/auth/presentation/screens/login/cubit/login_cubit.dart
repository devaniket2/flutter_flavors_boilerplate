import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/models/auth_user_model.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/login/cubit/login.state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit(this.authRepository) : super(LoginState());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));

      AuthUserModel? user = await authRepository.login(email, password);

      emit(state.copyWith(isLoading: false, isLoginDone: user != null));
    } catch (error) {
      emit(state.copyWith(isLoading: false, error: error.toString()));
    }
  }
}
