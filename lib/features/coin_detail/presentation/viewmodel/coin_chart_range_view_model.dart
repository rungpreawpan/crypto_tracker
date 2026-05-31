import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/coin_chart_range.dart';

class CoinChartRangeViewModel extends Notifier<CoinChartRange> {
  @override
  CoinChartRange build() {
    return CoinChartRange.oneDay;
  }

  void updateRange(CoinChartRange range) {
    state = range;
  }
}
