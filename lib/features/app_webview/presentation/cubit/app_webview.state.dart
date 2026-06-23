import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_webview.state.freezed.dart';

@freezed
abstract class AppWebviewState with _$AppWebviewState {
  const factory AppWebviewState({
    @Default(0.0) double loadingPercentage,
    @Default('') String title,
    @Default(false) bool canGoBack,
    @Default(false) bool canGoForward,
    @Default(0) int scrollY,
  }) = _AppWebviewState;
}
