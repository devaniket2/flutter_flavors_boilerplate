import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/dashboard/cubit/dashboard.state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AuthRepository authRepository;

  DashboardCubit(this.authRepository) : super(DashboardState());

  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  Future<void> logout() async {
    bool isOK = await authRepository.logout();

    if (isOK) {
      emit(state.copyWith(isLoggedOut: true));
    }
  }
}
