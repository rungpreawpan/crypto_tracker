import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppShellViewModel extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void selectTab(int index) {
    if (index == state) {
      return;
    }

    state = index;
  }
}
