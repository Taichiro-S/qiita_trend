import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '/pages/ranking/model/loaded_tags_state.dart';
import '/pages/ranking/repository/tags_repository.dart';

part 'loaded_tags_provider.g.dart';

@riverpod
class LoadedTags extends _$LoadedTags {
  @override
  LoadedTagsState build() {
    return const LoadedTagsState(
      tags: AsyncValue.loading(),
      lastDoc: null,
      isLoadingMore: false,
    );
  }

  Future<void> fetchTags({required TagsField fieldOrderBy}) async {
    final repository = ref.watch(tagsRepositoryProvider);
    state = state.copyWith(tags: const AsyncValue.loading());
    try {
      final newTags =
          await repository.getSortedTags(fieldOrderBy: fieldOrderBy);
      state = state.copyWith(
        tags: AsyncValue.data(newTags),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
      );
    } catch (e, s) {
      state = state.copyWith(tags: AsyncValue.error(e, s));
    }
  }

  Future<void> fetchMoreTags({required TagsField fieldOrderBy}) async {
    final repository = ref.watch(tagsRepositoryProvider);
    if (state.lastDoc == null ||
        state.tags is! AsyncData ||
        state.isLoadingMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newTags = await repository.getSortedTags(
          fieldOrderBy: fieldOrderBy, startAfter: state.lastDoc);
      state = state.copyWith(
        tags: AsyncValue.data([...(state.tags.value ?? []), ...newTags]),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
      );
    } catch (e, s) {
      state = state.copyWith(tags: AsyncValue.error(e, s));
    } finally {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  // Future<void> refreshTags({required TagsField fieldOrderBy}) async {
  //   try {
  //     final newTags =
  //         await repository.getSortedTags(fieldOrderBy: fieldOrderBy);
  //     state = state.copyWith(
  //       tags: AsyncValue.data(newTags),
  //       lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
  //     );
  //   } catch (e, s) {
  //     state = state.copyWith(tags: AsyncValue.error(e, s));
  //   }
  // }
}
