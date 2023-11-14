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

enum Collection {
  tags,
  weeklyRanking,
  monthlyRanking,
  ;

  String get name {
    switch (this) {
      case Collection.tags:
        return 'tags';
      case Collection.weeklyRanking:
        return 'weeklyRanking';
      case Collection.monthlyRanking:
        return 'monthlyRanking';
      default:
        return '';
    }
  }
}

enum RankedTagsSortOrder {
  itemsCount,
  followersCount,
  follwersCountChange,
  itemsCountChange,
  ;

  String get name {
    switch (this) {
      case RankedTagsSortOrder.itemsCount:
        return 'items_count';
      case RankedTagsSortOrder.followersCount:
        return 'followers_count';
      case RankedTagsSortOrder.follwersCountChange:
        return 'followers_count_change';
      case RankedTagsSortOrder.itemsCountChange:
        return 'items_count_change';
      default:
        return '';
    }
  }
}

enum HistoryProperty {
  follwersCountHistory,
  itemsCountHistory,
  weeklyHistory,
  monthlyHistory,
  ;

  String get name {
    switch (this) {
      case HistoryProperty.follwersCountHistory:
        return 'followers_count_history';
      case HistoryProperty.itemsCountHistory:
        return 'items_count_history';
      default:
        return '';
    }
  }

  int get length {
    switch (this) {
      case HistoryProperty.weeklyHistory:
        return 7;
      case HistoryProperty.monthlyHistory:
        return 30;
      default:
        return 0;
    }
  }
}
