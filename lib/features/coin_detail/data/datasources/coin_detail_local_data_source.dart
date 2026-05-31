import 'package:hive/hive.dart';

import '../models/coin_detail_dto.dart';
import '../models/coin_market_chart_dto.dart';

class CoinDetailLocalDataSource {
  final Box<Map> box;

  const CoinDetailLocalDataSource(this.box);

  Future<void> saveCoinDetail(CoinDetailDto coin) async {
    await box.put(coin.id, coin.toJson());
  }

  CoinDetailDto? getCoinDetail(String coinId) {
    final cached = box.get(coinId);

    if (cached == null) {
      return null;
    }

    return CoinDetailDto.fromJson(Map<String, dynamic>.from(cached));
  }

  Future<void> saveCoinMarketChart({
    required String coinId,
    required String currencyCode,
    required String days,
    required CoinMarketChartDto chart,
  }) async {
    await box.put(_chartKey(coinId, currencyCode, days), chart.toJson());
  }

  CoinMarketChartDto? getCoinMarketChart({
    required String coinId,
    required String currencyCode,
    required String days,
  }) {
    final cached = box.get(_chartKey(coinId, currencyCode, days));

    if (cached == null) {
      return null;
    }

    return CoinMarketChartDto.fromJson(Map<String, dynamic>.from(cached));
  }

  String _chartKey(String coinId, String currencyCode, String days) {
    return '${coinId}_${currencyCode}_chart_$days';
  }
}
