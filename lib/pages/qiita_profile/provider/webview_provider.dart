import 'package:flutter_riverpod/flutter_riverpod.dart';

final webViewProvider =
    StateNotifierProvider<WebViewNotifier, Map<String, bool>>((ref) {
  return WebViewNotifier();
});

class WebViewNotifier extends StateNotifier<Map<String, bool>> {
  WebViewNotifier() : super({'open': false, 'loading': false});

  void show() => state = {...state, 'open': true};
  void hide() => state = {...state, 'open': false};
  void loading() => state = {...state, 'loading': true};
  void loaded() => state = {...state, 'loading': false};
}
