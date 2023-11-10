import 'package:freezed_annotation/freezed_annotation.dart';
part 'webview_state.freezed.dart';

@freezed
class WebViewState with _$WebViewState {
  const factory WebViewState({
    required bool isOpen,
    required bool isLoading,
  }) = _WebViewState;
}
