import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/repository/tags_repository.dart';
part 'max_value_provider.g.dart';

@riverpod
Future<Map<String, int>> maxValue(MaxValueRef ref) async {
  final repository = ref.watch(tagsRepositoryProvider);
  final allTags = repository.getAllTags();
  final maxItemsCount = allTags.then((tags) => tags
      .map((e) => e.itemsCount)
      .reduce((value, element) =>
          int.parse(value) > int.parse(element) ? value : element));
  final maxFollowersCount = allTags.then((tags) => tags
      .map((e) => e.followersCount)
      .reduce((value, element) =>
          int.parse(value) > int.parse(element) ? value : element));
  return {
    'maxItemsCount': int.parse(await maxItemsCount),
    'maxFollowersCount': int.parse(await maxFollowersCount),
  };
}
