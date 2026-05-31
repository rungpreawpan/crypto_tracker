import 'package:flutter/material.dart';

import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/skeleton_box.dart';
import '../../../../shared/widgets/app_gradient_background.dart';
import 'market_loading_search_header.dart';

class MarketLoadingView extends StatelessWidget {
  const MarketLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppGradientBackground(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Column(
                children: [
                  _globalCardSkeleton(context),
                  const SizedBox(height: AppSpacing.md),
                  _trendingSectionSkeleton(),
                ],
              ),
            ),
          ),
          const SliverPersistentHeader(
            pinned: true,
            delegate: MarketLoadingSearchHeader(),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.xs,
              AppSpacing.md,
              AppSpacing.lg,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _marketRowSkeleton();
              }, childCount: 6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _globalCardSkeleton(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 72.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(height: 10.0, width: 88.0),
                SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    SkeletonBox(height: 28.0, width: 94.0),
                    SizedBox(width: AppSpacing.sm),
                    SkeletonBox(height: 18.0, width: 52.0),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Container(
              width: 1.0,
              height: 42.0,
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.12),
            ),
          ),
          const Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(height: 10.0, width: 54.0),
                SizedBox(height: AppSpacing.sm),
                SkeletonBox(height: 24.0, width: 78.0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trendingSectionSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(child: SkeletonBox(height: 10.0, width: 110.0)),
            SkeletonBox(height: 10.0, width: 72.0),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 64.0,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) {
              return const SizedBox(width: AppSpacing.sm);
            },
            itemBuilder: (context, index) {
              return _trendingCardSkeleton();
            },
          ),
        ),
      ],
    );
  }

  Widget _trendingCardSkeleton() {
    return Container(
      width: 168.0,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: const Row(
        children: [
          SkeletonBox(height: 34.0, width: 34.0),
          SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonBox(height: 12.0, width: 68.0),
                SizedBox(height: 6.0),
                SkeletonBox(height: 10.0, width: 34.0),
              ],
            ),
          ),
          SizedBox(width: AppSpacing.xs),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SkeletonBox(height: 12.0, width: 56.0),
              SizedBox(height: 6.0),
              SkeletonBox(height: 10.0, width: 42.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _marketRowSkeleton() {
    return const Padding(
      padding: EdgeInsets.only(bottom: AppSpacing.md),
      child: SkeletonBox(height: 76.0),
    );
  }
}
