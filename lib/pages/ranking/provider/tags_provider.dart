import 'package:qiita_trend/constant/default_values.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/tag_info.dart';
import '/pages/ranking/repository/tags_repository.dart';
part 'tags_provider.g.dart';

@riverpod
Future<List<TagInfo>> tags(TagsRef ref,
    {TagsField field = TagsField.items_count,
    int limit = DEFAULT_TAG_HISTORY_DAYS * 4}) async {
  final repository = ref.watch(tagsRepositoryProvider);
  return repository.getSortedTags(field: field, limit: limit);
}
