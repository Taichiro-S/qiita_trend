import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/constant/default_value.dart';
import 'package:qiita_trend/pages/qiita_profile/model/qiita_profile_state.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_following_tags_provider.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_profile_provider.dart';
import 'package:qiita_trend/pages/ranking/model/display_settings_state.dart';
import 'package:qiita_trend/pages/ranking/provider/display_settings_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/loaded_tags_provider.dart';
import 'package:qiita_trend/pages/ranking/provider/scroll_controller_provider.dart';
import 'package:qiita_trend/pages/ranking/widget/display_settings_widget.dart';
import 'package:qiita_trend/pages/ranking/widget/search_topic_widget.dart';
import 'package:qiita_trend/pages/ranking/widget/tag_container_widget.dart';
import 'package:qiita_trend/pages/ranking/widget/tag_history_widget.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
import 'package:qiita_trend/widget/circle_loading_widget.dart';

@RoutePage()
class RankingPage extends ConsumerWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadedTagsAsync = ref.watch(loadedTagsProvider);
    final loadedTagsNotifier = ref.read(loadedTagsProvider.notifier);
    final scrollController = ref.watch(scrollControllerNotifierProvider);
    final displaySettings = ref.watch(displaySettingsProvider);
    final showChart = ref.watch(displaySettingsProvider.select((state) {
      return state.showChart;
    }));
    ref.watch(qiitaAuthStorageProvider);
    ref.watch(qiitaFollowingTagsProvider);
    ref.watch(qiitaProfileProvider);
    ref.listen<AsyncValue<bool>>(qiitaAuthStorageProvider,
        (_, isQiitaAuthAsync) {
      if (isQiitaAuthAsync.value == true) {
        ref.read(qiitaProfileProvider.notifier).getProfile();
      }
    });
    ref.listen<QiitaProfileState>(qiitaProfileProvider, (_, qiitaProfileAsync) {
      final id = qiitaProfileAsync.qiitaProfile.value?.id;
      if (id != null) {
        ref
            .read(qiitaFollowingTagsProvider.notifier)
            .getFollowingTags(userId: id);
      }
    });
    ref.listen<DisplaySettingsState>(displaySettingsProvider,
        (previousState, state) {
      if (state != previousState) {
        loadedTagsNotifier.getRankedTags(
            timePeriod: state.timePeriod, sortOrder: state.sortOrder);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const SearchTopic(),
        actions: const <Widget>[
          DisplaySettingsWidget(),
        ],
      ),
      body: loadedTagsAsync.rankedTags.when(
        loading: () => const Center(
            child: CircleLoadingWidget(color: Colors.blue, fontSize: 20)),
        error: (error, stack) => Center(child: Text('エラー: $error')),
        data: (rankedTags) {
          return RefreshIndicator(
            child: ListView.builder(
              controller: scrollController,
              itemCount: rankedTags.length + 1,
              itemBuilder: (context, index) {
                if (loadedTagsAsync.isSearching) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      loadedTagsNotifier.stopSearching();
                    },
                    child: Container(),
                  );
                } else if (rankedTags.isEmpty) {
                  return const Center(
                      heightFactor: 20,
                      child: Text('トピックが見つかりませんでした😢',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)));
                }
                if (index == rankedTags.length) {
                  if (loadedTagsAsync.lastDoc != null &&
                      rankedTags.length >= DEFAULT_LOAD_TAGS) {
                    return const Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                    color: Colors.blue))));
                  } else if (rankedTags.length > 1) {
                    return const Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text('トピックがありません')));
                  } else {
                    return Container();
                  }
                }
                final rankedTag = rankedTags[index];
                return Card(
                    elevation: 3,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        TagContainerWidget(rankedTag: rankedTag, index: index),
                        showChart
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TagHistoryWidget(rankedTag: rankedTag))
                            : Container(),
                      ],
                    ));
              },
            ),
            onRefresh: () async {
              loadedTagsNotifier.getRankedTags(
                  timePeriod: displaySettings.timePeriod,
                  sortOrder: displaySettings.sortOrder);
            },
          );
        },
      ),
    );
  }
}
