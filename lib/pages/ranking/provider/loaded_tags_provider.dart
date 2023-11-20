import 'package:qiita_trend/constant/firestore_arg.dart';
import 'package:qiita_trend/pages/ranking/model/loaded_tags_state.dart';
import 'package:qiita_trend/pages/ranking/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/repository/ranked_tags_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'loaded_tags_provider.g.dart';

@riverpod
class LoadedTags extends _$LoadedTags {
  @override
  LoadedTagsState build() {
    return const LoadedTagsState(
      rankedTags: AsyncValue.loading(),
      lastDoc: null,
      isLoadingMore: false,
      isSearching: false,
      showSearchResult: false,
    );
  }

  Future<void> getRankedTags(
      {required Collection timePeriod,
      required RankedTagsSortOrder sortOrder}) async {
    final rankedTagsrepository = ref.watch(rankedTagsRepositoryProvider);
    state = state.copyWith(rankedTags: const AsyncValue.loading());
    try {
      final newTags = await rankedTagsrepository.fetchRankedTags(
          timePeriod: timePeriod, sortOrder: sortOrder);
      state = state.copyWith(
        rankedTags: AsyncValue.data(newTags),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
      );
    } catch (e, s) {
      state = state.copyWith(rankedTags: AsyncValue.error(e, s));
    }
  }

  Future<void> getMoreRankedTags(
      {required Collection timePeriod,
      required RankedTagsSortOrder sortOrder}) async {
    final rankedTagsrepository = ref.watch(rankedTagsRepositoryProvider);
    if (state.lastDoc == null ||
        state.rankedTags is! AsyncData ||
        state.isLoadingMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newTags = await rankedTagsrepository.fetchRankedTags(
          timePeriod: timePeriod,
          sortOrder: sortOrder,
          startAfter: state.lastDoc);
      state = state.copyWith(
        rankedTags:
            AsyncValue.data([...(state.rankedTags.value ?? []), ...newTags]),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
        isLoadingMore: false,
      );
    } catch (e, s) {
      state = state.copyWith(rankedTags: AsyncValue.error(e, s));
    } finally {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  Future<void> getSearchedTags(
      {required Collection timePeriod,
      required RankedTagsSortOrder sortOrder,
      required String searchWord}) async {
    final rankedTagsrepository = ref.watch(rankedTagsRepositoryProvider);
    state = state.copyWith(rankedTags: const AsyncValue.loading());
    try {
      final newTags = await rankedTagsrepository.fetchRankedTags(
          timePeriod: timePeriod, sortOrder: sortOrder, searchWord: searchWord);
      state = state.copyWith(
        rankedTags: AsyncValue.data(newTags),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
      );
    } catch (e, s) {
      state = state.copyWith(rankedTags: AsyncValue.error(e, s));
    }
  }

  Future<void> getMoreSearchedTags(
      {required Collection timePeriod,
      required RankedTagsSortOrder sortOrder,
      required String searchWord}) async {
    final rankedTagsrepository = ref.watch(rankedTagsRepositoryProvider);
    if (state.lastDoc == null ||
        state.rankedTags is! AsyncData ||
        state.isLoadingMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true);
    try {
      final newTags = await rankedTagsrepository.fetchRankedTags(
          timePeriod: timePeriod,
          sortOrder: sortOrder,
          startAfter: state.lastDoc,
          searchWord: searchWord);
      state = state.copyWith(
        rankedTags:
            AsyncValue.data([...(state.rankedTags.value ?? []), ...newTags]),
        lastDoc: newTags.isNotEmpty ? newTags.last.documentSnapshot : null,
        isLoadingMore: false,
      );
    } catch (e, s) {
      state = state.copyWith(rankedTags: AsyncValue.error(e, s));
    } finally {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void setSearchWord(String searchWord) {
    state = state.copyWith(isSearching: true);
    state = state.copyWith(searchWord: searchWord);
    state = state.copyWith(showSearchResult: false);
  }

  void clearSearchWord() {
    state = state.copyWith(isSearching: true);
    state = state.copyWith(searchWord: '');
    state = state.copyWith(showSearchResult: false);
  }

  void startSearching() {
    state = state.copyWith(isSearching: true);
    state = state.copyWith(showSearchResult: false);
  }

  void search({required String searchWord}) {
    final displaySettings = ref.watch(displaySettingsProvider);
    state = state.copyWith(isSearching: false);
    state = state.copyWith(searchWord: searchWord);
    state = state.copyWith(showSearchResult: true);

    getSearchedTags(
        timePeriod: displaySettings.timePeriod,
        sortOrder: displaySettings.sortOrder,
        searchWord: searchWord);
  }

  void stopSearching() {
    state = state.copyWith(searchWord: '');
    state = state.copyWith(isSearching: false);
    state = state.copyWith(showSearchResult: false);
  }
}
