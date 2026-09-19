import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard.state.freezed.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({
    @Default(0) int currentPage,
    @Default(false) bool isLoggedOut,
  }) = _DashboardState;
}
