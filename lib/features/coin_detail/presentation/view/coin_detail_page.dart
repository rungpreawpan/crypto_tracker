import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/offline_state_widget.dart';
import '../../../../shared/widgets/app_gradient_background.dart';
import '../../../../shared/widgets/coin_avatar.dart';
import '../../../../shared/widgets/sparkline_chart.dart';
import '../../domain/entities/coin_price_point.dart';
import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../providers/coin_detail_providers.dart';
import '../state/coin_chart_range.dart';
import '../state/coin_detail_state.dart';
import '../widgets/coin_detail_metric_tile.dart';

class CoinDetailPage extends ConsumerWidget {
  final String coinId;

  const CoinDetailPage({super.key, required this.coinId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(coinDetailViewModelProvider(coinId));
    final chartState = ref.watch(coinChartViewModelProvider(coinId));
    final selectedRange = ref.watch(coinChartRangeProvider(coinId));

    return Scaffold(
      appBar: AppBar(
        title: detailState.maybeWhen(
          data: (state) {
            return Text(state.coin?.name ?? 'coin_detail.title'.tr());
          },
          orElse: () {
            return Text('coin_detail.title'.tr());
          },
        ),
        actions: [
          detailState.maybeWhen(
            data: (state) {
              return _favoriteAction(ref, state);
            },
            orElse: () {
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: detailState.when(
        data: (state) {
          return AppGradientBackground(
            child: _detailContent(
              context,
              ref,
              state,
              chartState,
              selectedRange,
            ),
          );
        },
        error: (error, stackTrace) {
          return AppGradientBackground(
            child: AppErrorView(
              message: error.toString(),
              onRetry: () {
                ref.invalidate(coinDetailViewModelProvider(coinId));
              },
            ),
          );
        },
        loading: () {
          return const AppGradientBackground(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _favoriteAction(WidgetRef ref, CoinDetailState state) {
    return IconButton(
      onPressed: () {
        ref.read(coinDetailViewModelProvider(coinId).notifier).toggleFavorite();
      },
      icon: Icon(state.isFavorite ? Icons.star : Icons.star_border),
      color: state.isFavorite ? const Color(0xFFFFC107) : null,
    );
  }

  Widget _detailContent(
    BuildContext context,
    WidgetRef ref,
    CoinDetailState state,
    AsyncValue<List<CoinPricePoint>> chartState,
    CoinChartRange selectedRange,
  ) {
    final coin = state.coin;

    if (coin == null) {
      return const SizedBox.shrink();
    }

    return RefreshIndicator(
      onRefresh: () {
        ref.invalidate(coinChartViewModelProvider(coinId));
        return ref.read(coinDetailViewModelProvider(coinId).notifier).refresh();
      },
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        children: [
          if (state.isOffline) const OfflineStateWidget(),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailHeader(context, ref, state),
                const SizedBox(height: AppSpacing.md),
                _chartRangeSelector(context, ref, selectedRange),
                const SizedBox(height: AppSpacing.sm),
                _chartPanel(context, ref, chartState, selectedRange),
                const SizedBox(height: AppSpacing.md),
                _metricGrid(ref, state),
                const SizedBox(height: AppSpacing.lg),
                _aboutSection(context, coin.description),
                const SizedBox(height: AppSpacing.md),
                _marketDataSection(context, state, ref),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartPanel(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<CoinPricePoint>> chartState,
    CoinChartRange selectedRange,
  ) {
    return Container(
      height: 188.0,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: chartState.when(
              data: (points) {
                return _chartContent(context, points);
              },
              error: (error, stackTrace) {
                return Center(
                  child: Text(
                    'coin_detail.no_chart_data'.tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.64),
                    ),
                  ),
                );
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _axisLabels(selectedRange).map((label) {
              return _chartAxisLabel(context, label);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _chartContent(BuildContext context, List<CoinPricePoint> points) {
    final prices = points.map((point) {
      return point.price;
    }).toList();
    final chartColor = _chartColor(points);

    if (prices.length < 2) {
      return Center(
        child: Text(
          'coin_detail.no_chart_data'.tr(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
    }

    return SparklineChart(color: chartColor, points: prices);
  }

  Widget _chartRangeSelector(
    BuildContext context,
    WidgetRef ref,
    CoinChartRange selectedRange,
  ) {
    final ranges = [
      CoinChartRange.oneHour,
      CoinChartRange.fourHours,
      CoinChartRange.oneDay,
      CoinChartRange.sevenDays,
      CoinChartRange.oneMonth,
      CoinChartRange.sixMonths,
      CoinChartRange.oneYear,
    ];

    return Container(
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          for (final range in ranges)
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                onTap: () {
                  ref
                      .read(coinChartRangeProvider(coinId).notifier)
                      .updateRange(range);
                },
                child: _chartRangeLabel(
                  context,
                  _rangeLabel(range),
                  range == selectedRange,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _chartRangeLabel(BuildContext context, String label, bool selected) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.28)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: selected ? Colors.white : null,
        ),
      ),
    );
  }

  Widget _chartAxisLabel(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.58),
      ),
    );
  }

  Widget _aboutSection(BuildContext context, String description) {
    final cleanDescription = description.isEmpty
        ? 'coin_detail.no_description'.tr()
        : description.replaceAll(RegExp('<[^>]*>'), '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'coin_detail.description'.tr(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          cleanDescription,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            height: 1.45,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.72),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            _showDescriptionSheet(context, cleanDescription);
          },
          child: Text(
            'coin_detail.read_more'.tr(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  void _showDescriptionSheet(BuildContext context, String description) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.62,
          minChildSize: 0.35,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xl),
                ),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.outline.withValues(alpha: 0.08),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.md,
                        AppSpacing.sm,
                        AppSpacing.sm,
                        AppSpacing.xs,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(AppRadius.lg),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'coin_detail.description'.tr(),
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w900),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: const Icon(Icons.close),
                                style: IconButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.42),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1.0,
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.08),
                    ),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.md,
                          AppSpacing.md,
                          AppSpacing.md,
                          AppSpacing.lg,
                        ),
                        children: [
                          Text(
                            description,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  height: 1.58,
                                  color: Theme.of(context).colorScheme.onSurface
                                      .withValues(alpha: 0.78),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _detailHeader(
    BuildContext context,
    WidgetRef ref,
    CoinDetailState state,
  ) {
    final coin = state.coin!;
    final currency = ref.watch(appCurrencyProvider);
    final changeColor = coin.priceChangePercentage24h >= 0
        ? AppColors.positive
        : AppColors.negative;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CoinAvatar(imageUrl: coin.image, size: 52.0),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    coin.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Text(
                        coin.symbol.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.62),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      _rankChip(context, coin.marketCapRank),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                CurrencyFormatter.standard(
                  coin.currentPrice,
                  symbol: currency.symbol,
                ),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: _changePill(
                context,
                changeColor,
                coin.priceChangePercentage24h,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _changePill(
    BuildContext context,
    Color changeColor,
    num priceChangePercentage24h,
  ) {
    final backgroundColor = priceChangePercentage24h >= 0
        ? AppColors.positive.withValues(alpha: 0.2)
        : const Color(0xFFFF7AA8).withValues(alpha: 0.24);
    final icon = priceChangePercentage24h >= 0
        ? Icons.north_east
        : Icons.south_east;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: changeColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '${priceChangePercentage24h.abs().toStringAsFixed(2)}%',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: changeColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '(24h)',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: changeColor.withValues(alpha: 0.82),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rankChip(BuildContext context, int rank) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        '${'market.rank_label'.tr()} #$rank',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  Widget _metricGrid(WidgetRef ref, CoinDetailState state) {
    final coin = state.coin!;
    final currency = ref.watch(appCurrencyProvider);

    return Column(
      children: [
        _metricRow(
          left: CoinDetailMetricTile(
            label: 'market.market_cap'.tr(),
            value: CurrencyFormatter.compact(
              coin.marketCap,
              symbol: currency.symbol,
            ),
          ),
          right: CoinDetailMetricTile(
            label: 'market.volume_24h'.tr(),
            value: CurrencyFormatter.compact(
              coin.totalVolume,
              symbol: currency.symbol,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _metricRow(
          left: CoinDetailMetricTile(
            label: 'coin_detail.circulating_supply'.tr(),
            value: _supplyText(coin.circulatingSupply, coin.symbol),
          ),
          right: CoinDetailMetricTile(
            label: 'coin_detail.max_supply'.tr(),
            value: _supplyText(coin.maxSupply, coin.symbol),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _metricRow(
          left: CoinDetailMetricTile(
            label: 'coin_detail.ath'.tr(),
            value: CurrencyFormatter.standard(
              coin.ath,
              symbol: currency.symbol,
            ),
          ),
          right: CoinDetailMetricTile(
            label: 'coin_detail.price_change_24h'.tr(),
            value: CurrencyFormatter.percent(coin.priceChangePercentage24h),
          ),
        ),
      ],
    );
  }

  Widget _metricRow({required Widget left, required Widget right}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: AppSpacing.sm),
        Expanded(child: right),
      ],
    );
  }

  Widget _marketDataSection(
    BuildContext context,
    CoinDetailState state,
    WidgetRef ref,
  ) {
    final coin = state.coin!;
    final currency = ref.watch(appCurrencyProvider);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'coin_detail.market_data'.tr(),
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          _marketDataRow(
            context,
            'market.rank_label'.tr(),
            '#${coin.marketCapRank}',
          ),
          _marketDataRow(
            context,
            'market.market_cap'.tr(),
            CurrencyFormatter.compact(coin.marketCap, symbol: currency.symbol),
          ),
          _marketDataRow(
            context,
            'coin_detail.fully_diluted_valuation'.tr(),
            CurrencyFormatter.compact(
              coin.totalSupply * coin.currentPrice,
              symbol: currency.symbol,
            ),
          ),
          _marketDataRow(
            context,
            'market.volume_24h'.tr(),
            CurrencyFormatter.compact(
              coin.totalVolume,
              symbol: currency.symbol,
            ),
          ),
          _marketDataRow(
            context,
            'coin_detail.circulating_supply'.tr(),
            _supplyText(coin.circulatingSupply, coin.symbol),
          ),
          _marketDataRow(
            context,
            'coin_detail.total_supply'.tr(),
            _supplyText(coin.totalSupply, coin.symbol),
          ),
          _marketDataRow(
            context,
            'coin_detail.max_supply'.tr(),
            _supplyText(coin.maxSupply, coin.symbol),
          ),
        ],
      ),
    );
  }

  Widget _marketDataRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.62),
              ),
            ),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  String _supplyText(num value, String symbol) {
    if (value <= 0) {
      return '-';
    }

    final formatter = NumberFormat.compact();
    return '${formatter.format(value)} ${symbol.toUpperCase()}';
  }

  Color _chartColor(List<CoinPricePoint> points) {
    if (points.length < 2) {
      return AppColors.positive;
    }

    if (points.last.price >= points.first.price) {
      return AppColors.positive;
    }

    return AppColors.negative;
  }

  String _rangeLabel(CoinChartRange range) {
    if (range == CoinChartRange.oneHour) {
      return '1H';
    }

    if (range == CoinChartRange.fourHours) {
      return '4H';
    }

    if (range == CoinChartRange.oneDay) {
      return '1D';
    }

    if (range == CoinChartRange.sevenDays) {
      return '7D';
    }

    if (range == CoinChartRange.oneMonth) {
      return '1M';
    }

    if (range == CoinChartRange.sixMonths) {
      return '6M';
    }

    if (range == CoinChartRange.oneYear) {
      return '1Y';
    }

    return '1Y';
  }

  List<String> _axisLabels(CoinChartRange range) {
    if (range == CoinChartRange.oneHour) {
      return _hourAxisLabels(const [60, 40, 20, 0]);
    }

    if (range == CoinChartRange.fourHours) {
      return _hourAxisLabels(const [240, 160, 80, 0]);
    }

    if (range == CoinChartRange.oneDay) {
      return _hourAxisLabels(const [1440, 960, 480, 0]);
    }

    if (range == CoinChartRange.sevenDays) {
      return _dayAxisLabels(const [7, 5, 3, 0]);
    }

    if (range == CoinChartRange.oneMonth) {
      return _dayAxisLabels(const [30, 20, 10, 0]);
    }

    if (range == CoinChartRange.sixMonths) {
      return _monthAxisLabels(const [6, 4, 2, 0]);
    }

    if (range == CoinChartRange.oneYear) {
      return _monthAxisLabels(const [12, 8, 4, 0]);
    }

    return _monthAxisLabels(const [12, 8, 4, 0]);
  }

  List<String> _hourAxisLabels(List<int> minuteOffsets) {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');

    return minuteOffsets.map((offset) {
      return formatter.format(now.subtract(Duration(minutes: offset)));
    }).toList();
  }

  List<String> _dayAxisLabels(List<int> dayOffsets) {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM');

    return dayOffsets.map((offset) {
      return formatter.format(now.subtract(Duration(days: offset)));
    }).toList();
  }

  List<String> _monthAxisLabels(List<int> monthOffsets) {
    final now = DateTime.now();
    final formatter = DateFormat('MMM');

    return monthOffsets.map((offset) {
      return formatter.format(_subtractMonths(now, offset));
    }).toList();
  }

  DateTime _subtractMonths(DateTime dateTime, int months) {
    final totalMonths = (dateTime.year * 12) + dateTime.month - 1 - months;
    final year = totalMonths ~/ 12;
    final month = (totalMonths % 12) + 1;
    final day = dateTime.day.clamp(1, DateUtils.getDaysInMonth(year, month));

    return DateTime(
      year,
      month,
      day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond,
      dateTime.microsecond,
    );
  }
}
