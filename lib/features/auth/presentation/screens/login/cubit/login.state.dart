import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    @Default(false) bool isLoginDone,
    @Default(null) String? error,
  }) = _LoginState;
}
