import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../app_shell/presentation/providers/app_shell_providers.dart';

class FavoritesEmptyStateView extends ConsumerWidget {
  const FavoritesEmptyStateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _emptyIllustration(context),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'favorites.empty_title'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'favorites.empty_message'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.68),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  ref.read(appShellViewModelProvider.notifier).selectTab(0);
                },
                child: Text('favorites.explore_markets'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyIllustration(BuildContext context) {
    return SizedBox(
      width: 128.0,
      height: 128.0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.16),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Icon(
          Icons.query_stats,
          size: 56.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
