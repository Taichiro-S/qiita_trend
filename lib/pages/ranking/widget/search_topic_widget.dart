import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_following_tags_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';

class SearchTopic extends ConsumerWidget {
  const SearchTopic({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();
    final loadedTagsNotifier = ref.read(loadedTagsProvider.notifier);
    final loadedTags = ref.watch(loadedTagsProvider);
    ref.watch(qiitaFollowingTagsProvider);
    final displaySettings = ref.watch(displaySettingsProvider);
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
          prefixIcon: loadedTags.isSearching ||
                  loadedTags.showSearchResult ||
                  loadedTags.searchWord != null &&
                      loadedTags.searchWord!.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    if (loadedTags.isSearching) {
                      FocusScope.of(context).unfocus();
                      searchController.clear();
                      loadedTagsNotifier.stopSearching();
                      loadedTagsNotifier.getRankedTags(
                          timePeriod: displaySettings.timePeriod,
                          sortOrder: displaySettings.sortOrder);
                    } else if (loadedTags.showSearchResult) {
                      FocusScope.of(context).unfocus();
                      searchController.clear();
                      loadedTagsNotifier.stopSearching();
                      loadedTagsNotifier.getRankedTags(
                          timePeriod: displaySettings.timePeriod,
                          sortOrder: displaySettings.sortOrder);
                    }
                  },
                  icon: const Icon(Icons.arrow_back))
              : const Icon(Icons.search),
          suffixIcon: loadedTags.isSearching
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    loadedTagsNotifier.clearSearchWord();
                  },
                  icon: const Icon(Icons.close))
              : null,
          hintText: !loadedTags.isSearching &&
                  loadedTags.searchWord != null &&
                  loadedTags.searchWord!.isNotEmpty
              ? loadedTags.searchWord
              : ''),
      onTap: () {
        loadedTagsNotifier.startSearching();
      },
      onSubmitted: (value) {
        FocusScope.of(context).unfocus();
        loadedTagsNotifier.search(searchWord: value);
      },
    );
  }
}
