import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/features/auth/presentation/screens/dashboard/cubit/dashboard.state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardState());

  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }
}
