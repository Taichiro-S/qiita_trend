import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_following_tags_provider.dart';
import 'package:qiita_trend/pages/qiita_profile/provider/qiita_profile_provider.dart';
import 'package:qiita_trend/pages/ranking/model/ranked_tag.dart';
import 'package:qiita_trend/provider/qiita_auth_storage_provider.dart';
import 'package:qiita_trend/routes/router.dart';

class FavoriteIconWidget extends ConsumerStatefulWidget {
  final RankedTag rankedTag;
  const FavoriteIconWidget({Key? key, required this.rankedTag})
      : super(key: key);
  @override
  ConsumerState<FavoriteIconWidget> createState() => _FavoriteIconWidgetState();
}

class _FavoriteIconWidgetState extends ConsumerState<FavoriteIconWidget>
    with SingleTickerProviderStateMixin {
  bool isFollowing = false;
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 20.0, end: 24.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorite() async {
    if (isFollowing) {
      _animationController.reverse();
    } else {
      await _animationController.forward();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final qiitaAuth = ref.watch(qiitaAuthStorageProvider);
    final follwoingTagsAsync = ref.watch(qiitaFollowingTagsProvider);
    final followingTagsNotifier = ref.read(qiitaFollowingTagsProvider.notifier);
    final qiitaProfileAsync = ref.watch(qiitaProfileProvider);
    final router = AutoRouter.of(context);
    final updatedFollowingTags =
        follwoingTagsAsync.followingTags.value?.map((e) => e.id).toList() ?? [];
    final updatedIsFollowing =
        updatedFollowingTags.contains(widget.rankedTag.id);

    if (updatedIsFollowing != isFollowing) {
      setState(() {
        isFollowing = updatedIsFollowing;
      });
    }
    return Container(
        child: qiitaAuth.when(data: (isAuth) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          if (!isAuth) {
            return IconButton(
                onPressed: () {
                  showDialog<Widget>(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text("Qiitaにログインしてね！"),
                          content: const Text("ログインページに移動しますか？"),
                          actions: [
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: const Text('キャンセル'),
                            ),
                            CupertinoDialogAction(
                                child: const Text('移動'),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await router.push(const UserSettingsRoute());
                                })
                          ],
                        );
                      });
                  return;
                },
                icon: const Icon(Icons.favorite_border, color: Colors.grey));
          } else {
            return qiitaProfileAsync.qiitaProfile.when(
                data: (user) {
                  return follwoingTagsAsync.followingTags.when(
                      data: (tags) {
                        return IconButton(
                          icon: Icon(
                            isFollowing
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFollowing ? Colors.red : Colors.grey,
                            size: _animation.value,
                          ),
                          onPressed: () async {
                            if (isLoading) return;
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              if (isFollowing) {
                                if (Theme.of(context).platform ==
                                    TargetPlatform.iOS) {
                                  showDialog<Widget>(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text(
                                              "タグ\"${widget.rankedTag.id}\"のフォローを解除しますか？"),
                                          actions: [
                                            CupertinoDialogAction(
                                              isDestructiveAction: true,
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('キャンセル'),
                                            ),
                                            CupertinoDialogAction(
                                                child: const Text('フォロー解除'),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                  await followingTagsNotifier
                                                      .unfollowTag(
                                                          userId: user.id,
                                                          tagId: widget
                                                              .rankedTag.id);
                                                  await _toggleFavorite();
                                                  await Future<void>.delayed(
                                                      const Duration(
                                                          milliseconds: 300));
                                                })
                                          ],
                                        );
                                      });
                                }
                                if (Theme.of(context).platform ==
                                    TargetPlatform.android) {}
                              } else {
                                showDialog<Widget>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            "タグ\"${widget.rankedTag.id}\"をフォローしますか？"),
                                        actions: [
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('キャンセル'),
                                          ),
                                          CupertinoDialogAction(
                                              child: const Text('フォロー'),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await followingTagsNotifier
                                                    .followTag(
                                                        userId: user.id,
                                                        tagId: widget
                                                            .rankedTag.id);
                                                await _toggleFavorite();
                                                await Future<void>.delayed(
                                                    const Duration(
                                                        milliseconds: 300));
                                              }),
                                        ],
                                      );
                                    });
                              }
                            } catch (e) {
                              /* TODO 
                          error modal 
                          */
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                        );
                      },
                      loading: () => IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                            size: _animation.value,
                          ),
                          onPressed: () {}),
                      error: (error, stackTrace) {
                        return Text(error.toString());
                      });
                },
                loading: () => IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                      size: _animation.value,
                    ),
                    onPressed: () {}),
                error: (error, stackTrace) {
                  return Text(error.toString());
                });
          }
        },
      );
    }, loading: () {
      return const CircularProgressIndicator();
    }, error: (error, stackTrace) {
      return Text(error.toString());
    }));
  }
}
