import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavors_boilerplate/features/app_webview/presentation/cubit/app_webview.state.dart';

class AppWebviewCubit extends Cubit<AppWebviewState> {
  AppWebviewCubit() : super(AppWebviewState());

  void updateLoadingPercentage(double perc) {
    emit(state.copyWith(loadingPercentage: perc));
  }

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateCanGoBack(bool value) {
    emit(state.copyWith(canGoBack: value));
  }

  void updateCanGoFoward(bool value) {
    emit(state.copyWith(canGoForward: value));
  }

  void updateScrollY(int y, {int? forcedValue}) {
    emit(state.copyWith(scrollY: forcedValue ?? y));
  }
}
