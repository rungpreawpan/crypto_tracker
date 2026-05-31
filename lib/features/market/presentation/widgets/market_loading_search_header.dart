import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/skeleton_box.dart';

class MarketLoadingSearchHeader extends SliverPersistentHeaderDelegate {
  const MarketLoadingSearchHeader();

  @override
  double get minExtent {
    return 64.0;
  }

  @override
  double get maxExtent {
    return 64.0;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).scaffoldBackgroundColor.withValues(alpha: 0.96),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.sm,
        ),
        child: Container(
          height: 48.0,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.08),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: const Row(
            children: [
              SkeletonBox(height: 18.0, width: 18.0),
              SizedBox(width: AppSpacing.sm),
              Expanded(
                child: SkeletonBox(height: 14.0, width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(MarketLoadingSearchHeader oldDelegate) {
    return false;
  }
}
