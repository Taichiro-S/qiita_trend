enum TagsField {
  id,
  iconUrl,
  followersCount,
  itemsCount,
  ;

  String get name {
    switch (this) {
      case TagsField.id:
        return 'id';
      case TagsField.iconUrl:
        return 'icon_url';
      case TagsField.followersCount:
        return 'followers_count';
      case TagsField.itemsCount:
        return 'items_count';
      default:
        return '';
    }
  }
}
