import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesEditModeViewModel extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void startEditing() {
    state = true;
  }

  void stopEditing() {
    state = false;
  }
}
