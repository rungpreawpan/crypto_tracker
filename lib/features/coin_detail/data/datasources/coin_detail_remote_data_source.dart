import '../../../../core/network/coingecko_api.dart';
import '../models/coin_detail_dto.dart';
import '../models/coin_market_chart_dto.dart';

class CoinDetailRemoteDataSource {
  final CoinGeckoApi api;

  const CoinDetailRemoteDataSource(this.api);

  Future<CoinDetailDto> getCoinDetail(String coinId) async {
    return api.getCoinDetail(
      coinId: coinId,
      localization: false,
      tickers: false,
      marketData: true,
      communityData: false,
      developerData: false,
    );
  }

  Future<CoinMarketChartDto> getCoinMarketChart({
    required String coinId,
    required String currencyCode,
    required String days,
  }) async {
    return api.getCoinMarketChart(
      coinId: coinId,
      currency: currencyCode,
      days: days,
    );
  }
}
