import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/pages/ranking/model/tag_info.dart';

class TagChangesContainer extends ConsumerWidget {
  final TagInfo tag;
  const TagChangesContainer({super.key, required this.tag});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white70,
            backgroundImage: tag.iconUrl != null
                ? NetworkImage(tag.iconUrl!)
                : const AssetImage('assets/images/no_image.png')
                    as ImageProvider<Object>,
            radius: 25,
          ),
          title: Text(
            tag.id,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                tag.itemsCount,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                tag.followersCount,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.more_vert),
        ));
  }
}
