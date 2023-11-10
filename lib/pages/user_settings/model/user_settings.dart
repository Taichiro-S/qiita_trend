import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_settings.freezed.dart';

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String fieldOrderBy,
    required int historyDays,
  }) = _UserSettings;
}
