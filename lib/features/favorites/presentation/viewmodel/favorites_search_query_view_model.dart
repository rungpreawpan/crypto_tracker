import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesSearchQueryViewModel extends Notifier<String> {
  @override
  String build() {
    return '';
  }

  void updateQuery(String query) {
    state = query;
  }
}
