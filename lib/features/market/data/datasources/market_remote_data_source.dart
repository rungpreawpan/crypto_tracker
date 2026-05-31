import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/coingecko_api.dart';
import '../models/coin_market_dto.dart';
import '../models/global_market_dto.dart';
import '../models/trending_coin_dto.dart';

class MarketRemoteDataSource {
  final CoinGeckoApi api;

  const MarketRemoteDataSource(this.api);

  Future<List<CoinMarketDto>> getMarketCoins({
    required int page,
    required String currencyCode,
  }) async {
    return api.getMarketCoins(
      currency: currencyCode,
      order: ApiConstants.marketOrder,
      perPage: ApiConstants.marketPageSize,
      page: page,
      sparkline: true,
    );
  }

  Future<GlobalMarketDto> getGlobalMarket() async {
    return api.getGlobalMarket();
  }

  Future<List<TrendingCoinDto>> getTrendingCoins() async {
    final response = await api.getTrendingCoins();
    return response.coins;
  }
}
