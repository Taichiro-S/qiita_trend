import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/firestore_arg.dart';

import '/pages/ranking/model/tag_info.dart';
import '/pages/ranking/repository/tags_repository.dart';

class TagsState {
  final AsyncValue<List<TagInfo>> tags;
  final DocumentSnapshot? lastDoc;
  final bool isLoadingMore;

  TagsState({required this.tags, this.lastDoc, this.isLoadingMore = false});

  TagsState.initial()
      : tags = const AsyncValue.loading(),
        lastDoc = null,
        isLoadingMore = false;

  TagsState copyWith({
    AsyncValue<List<TagInfo>>? tags,
    DocumentSnapshot? lastDoc,
    bool? isLoadingMore,
  }) {
    return TagsState(
      tags: tags ?? this.tags,
      lastDoc: lastDoc ?? this.lastDoc,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class TagsNotifier extends StateNotifier<TagsState> {
  final TagsRepository _repository;
  TagsNotifier(this._repository) : super(TagsState.initial());

  Future<void> fetchTags({required TagsField fieldOrderBy}) async {
    state = state.copyWith(tags: const AsyncValue.loading());
    try {
      final newTags =
          await _repository.getSortedTags(fieldOrderBy: fieldOrderBy);
      state = state.copyWith(
        tags: AsyncValue.data(newTags),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
      );
    } catch (e, s) {
      state = state.copyWith(tags: AsyncValue.error(e, s));
    }
  }

  Future<void> fetchMoreTags({required TagsField fieldOrderBy}) async {
    if (state.lastDoc == null ||
        state.tags is! AsyncData ||
        state.isLoadingMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newTags = await _repository.getSortedTags(
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

  Future<void> refreshTags({required TagsField fieldOrderBy}) async {
    state = TagsState.initial();
    await fetchTags(fieldOrderBy: fieldOrderBy);
  }
}

final tagsProvider = StateNotifierProvider<TagsNotifier, TagsState>((ref) {
  return TagsNotifier(ref.read(tagsRepositoryProvider));
});
