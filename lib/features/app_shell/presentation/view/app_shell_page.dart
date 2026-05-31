import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/app_bottom_navigation_bar.dart';
import '../../../../shared/widgets/app_gradient_background.dart';
import '../../../favorites/presentation/providers/favorite_providers.dart';
import '../../../favorites/presentation/view/favorites_page.dart';
import '../../../market/presentation/view/market_page.dart';
import '../../../settings/presentation/view/settings_page.dart';
import '../providers/app_shell_providers.dart';

class AppShellPage extends ConsumerWidget {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(appShellViewModelProvider);

    return Scaffold(
      appBar: _appBar(context, ref, selectedIndex),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: selectedIndex,
        onDestinationSelected: (index) {
          ref.read(appShellViewModelProvider.notifier).selectTab(index);
        },
      ),
      body: AppGradientBackground(
        child: IndexedStack(
          index: selectedIndex,
          children: [
            const MarketPage(),
            const FavoritesPage(),
            const SettingsPage(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(
    BuildContext context,
    WidgetRef ref,
    int selectedIndex,
  ) {
    if (selectedIndex == 1) {
      return _favoritesAppBar(ref);
    }

    if (selectedIndex == 2) {
      return _titleAppBar(ref, 'settings.title'.tr());
    }

    return _titleAppBar(ref, 'market.nav_markets'.tr());
  }

  PreferredSizeWidget _favoritesAppBar(WidgetRef ref) {
    final editMode = ref.watch(favoriteEditModeProvider);
    final favoriteIds = ref.watch(favoritesViewModelProvider).asData?.value;
    final hasFavorites = favoriteIds?.isNotEmpty ?? false;

    if (editMode && hasFavorites) {
      return AppBar(
        leading: IconButton(
          onPressed: () {
            ref.read(favoriteEditModeProvider.notifier).stopEditing();
          },
          icon: const Icon(Icons.close),
        ),
        title: Text(
          'favorites.edit_title'.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(favoriteEditModeProvider.notifier).stopEditing();
            },
            child: Text('favorites.done'.tr()),
          ),
        ],
      );
    }

    return AppBar(
      centerTitle: false,
      title: Text(
        'favorites.title'.tr(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: hasFavorites
          ? [
              TextButton(
                onPressed: () {
                  ref.read(favoriteEditModeProvider.notifier).startEditing();
                },
                child: Text(
                  'favorites.edit'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ]
          : null,
    );
  }

  PreferredSizeWidget _titleAppBar(WidgetRef ref, String title) {
    return AppBar(
      centerTitle: false,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
