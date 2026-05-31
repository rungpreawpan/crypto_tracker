import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import 'search_input_section.dart';

class MarketPinnedSearchHeader extends SliverPersistentHeaderDelegate {
  final ValueChanged<String> onSearchChanged;

  const MarketPinnedSearchHeader({required this.onSearchChanged});

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
        child: Column(
          children: [SearchInputSection(onChanged: onSearchChanged)],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(MarketPinnedSearchHeader oldDelegate) {
    return oldDelegate.onSearchChanged != onSearchChanged;
  }
}
