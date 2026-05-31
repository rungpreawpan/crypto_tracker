import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/domain/entities/app_currency.dart';
import '../../../settings/presentation/providers/currency_providers.dart';
import '../../domain/entities/coin_price_point.dart';
import '../providers/coin_detail_providers.dart';
import '../state/coin_chart_range.dart';

class CoinChartViewModel extends AsyncNotifier<List<CoinPricePoint>> {
  final String coinId;

  CoinChartViewModel(this.coinId);

  @override
  Future<List<CoinPricePoint>> build() async {
    final currency = ref.watch(appCurrencyProvider);
    final range = ref.watch(coinChartRangeProvider(coinId));
    final points = await ref
        .read(getCoinMarketChartUseCaseProvider)
        .call(
          coinId: coinId,
          currencyCode: currency.code,
          days: _daysForRange(range),
          forceRefresh: false,
        );

    if (range == CoinChartRange.oneHour) {
      return _recentPoints(points, Duration.millisecondsPerHour);
    }

    if (range == CoinChartRange.fourHours) {
      return _recentPoints(points, Duration.millisecondsPerHour * 4);
    }

    return points;
  }

  String _daysForRange(CoinChartRange range) {
    if (range == CoinChartRange.sevenDays) {
      return '7';
    }

    if (range == CoinChartRange.oneMonth) {
      return '30';
    }

    if (range == CoinChartRange.sixMonths) {
      return '180';
    }

    if (range == CoinChartRange.oneYear) {
      return '365';
    }

    return '1';
  }

  List<CoinPricePoint> _recentPoints(
    List<CoinPricePoint> points,
    int durationInMilliseconds,
  ) {
    if (points.isEmpty) {
      return points;
    }

    final latestTimestamp = points.last.timestamp;
    final earliestTimestamp = latestTimestamp - durationInMilliseconds;

    return points.where((point) {
      return point.timestamp >= earliestTimestamp;
    }).toList();
  }
}
