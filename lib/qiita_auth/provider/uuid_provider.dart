import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'uuid_provider.g.dart';

@riverpod
String uuid(UuidRef ref) {
  const uuid = Uuid();
  return uuid.v4();
}
