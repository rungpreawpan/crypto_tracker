import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      height: 72.0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      indicatorColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.22),
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.query_stats_outlined),
          selectedIcon: const Icon(Icons.query_stats),
          label: 'market.nav_markets'.tr(),
        ),
        NavigationDestination(
          icon: const Icon(Icons.star_border),
          selectedIcon: const Icon(Icons.star),
          label: 'favorites.title'.tr(),
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: 'settings.title'.tr(),
        ),
      ],
    );
  }
}
