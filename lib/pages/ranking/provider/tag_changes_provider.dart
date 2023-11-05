import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/tag_change.dart';
import '/pages/ranking/repository/tag_changes_repository.dart';
part 'tag_changes_provider.g.dart';

@riverpod
Future<List<TagChange>> tagChanges(TagChangesRef ref,
    {required String id}) async {
  final repository = ref.watch(tagChangesRepositoryProvider);
  return repository.getTagChanges(id);
}
