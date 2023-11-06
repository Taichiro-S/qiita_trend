import 'package:flutter_riverpod/flutter_riverpod.dart';

final propertyProvider = StateNotifierProvider<PropertyNotifier, String>((ref) {
  return PropertyNotifier();
});

class PropertyNotifier extends StateNotifier<String> {
  PropertyNotifier() : super('itemsCount');
  void change(String value) => state = value;
}
