import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/ranking/model/tag_info.dart';
import '/ranking/repository/tags_repository.dart';
part 'tags_provider.g.dart';

@riverpod
Future<List<TagInfo>> tags(TagsRef ref) async {
  final repository = ref.watch(tagsRepositoryProvider);
  return repository.getAllTopics();
}
