import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/qiita_profile/model/webview_state.dart';
part 'webview_provider.g.dart';

@riverpod
class WebView extends _$WebView {
  @override
  WebViewState build() {
    return const WebViewState(isOpen: false, isLoading: false);
  }

  void show() => state = state.copyWith(isOpen: true);
  void hide() => state = state.copyWith(isOpen: false);
  void loading() => state = state.copyWith(isLoading: true);
  void loaded() => state = state.copyWith(isLoading: false);
}
