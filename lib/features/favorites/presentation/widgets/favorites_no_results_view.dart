import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';

class FavoritesNoResultsView extends StatelessWidget {
  const FavoritesNoResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 88.0),
      child: Column(
        children: [
          _noResultsIllustration(context),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'favorites.no_results_title'.tr(),
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'favorites.no_results_message'.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.66),
            ),
          ),
        ],
      ),
    );
  }

  Widget _noResultsIllustration(BuildContext context) {
    return SizedBox(
      width: 118.0,
      height: 118.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 68.0,
            height: 82.0,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
          Positioned(
            right: 22.0,
            bottom: 20.0,
            child: Icon(
              Icons.search,
              size: 62.0,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.36),
            ),
          ),
        ],
      ),
    );
  }
}
