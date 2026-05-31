import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/app_shell_view_model.dart';

final appShellViewModelProvider = NotifierProvider<AppShellViewModel, int>(() {
  return AppShellViewModel();
});
