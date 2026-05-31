import 'package:hive/hive.dart';

import '../../../../core/constants/local_storage_keys.dart';
import '../models/coin_market_dto.dart';
import '../models/global_market_dto.dart';
import '../models/trending_coin_dto.dart';

class MarketLocalDataSource {
  final Box<Map> box;

  const MarketLocalDataSource(this.box);

  Future<void> saveMarketCoins({
    required int page,
    required String currencyCode,
    required List<CoinMarketDto> coins,
  }) async {
    final key = '${LocalStorageKeys.marketPagePrefix}${currencyCode}_$page';
    final data = {
      'coins': coins.map((coin) {
        return coin.toJson();
      }).toList(),
    };

    await box.put(key, data);
  }

  List<CoinMarketDto> getMarketCoins({
    required int page,
    required String currencyCode,
  }) {
    final key = '${LocalStorageKeys.marketPagePrefix}${currencyCode}_$page';
    final cached = box.get(key);
    final coins = cached?['coins'];

    if (coins is! List) {
      return [];
    }

    return coins.map((item) {
      return CoinMarketDto.fromJson(Map<String, dynamic>.from(item as Map));
    }).toList();
  }

  Future<void> saveGlobalMarket(GlobalMarketDto data) async {
    await box.put(LocalStorageKeys.globalMarket, data.toJson());
  }

  GlobalMarketDto? getGlobalMarket() {
    final cached = box.get(LocalStorageKeys.globalMarket);

    if (cached == null) {
      return null;
    }

    return GlobalMarketDto.fromJson(Map<String, dynamic>.from(cached));
  }

  Future<void> saveTrendingCoins(List<TrendingCoinDto> coins) async {
    final data = {
      'coins': coins.map((coin) {
        return coin.toJson();
      }).toList(),
    };

    await box.put(LocalStorageKeys.trendingCoins, data);
  }

  List<TrendingCoinDto> getTrendingCoins() {
    final cached = box.get(LocalStorageKeys.trendingCoins);
    final coins = cached?['coins'];

    if (coins is! List) {
      return [];
    }

    return coins.map((item) {
      return TrendingCoinDto.fromJson(Map<String, dynamic>.from(item as Map));
    }).toList();
  }
}
