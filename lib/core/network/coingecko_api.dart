import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/api_constants.dart';
import '../../features/coin_detail/data/models/coin_detail_dto.dart';
import '../../features/coin_detail/data/models/coin_market_chart_dto.dart';
import '../../features/market/data/models/coin_market_dto.dart';
import '../../features/market/data/models/global_market_dto.dart';
import '../../features/market/data/models/trending_coins_response_dto.dart';

part 'coingecko_api.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class CoinGeckoApi {
  factory CoinGeckoApi(Dio dio, {String baseUrl}) = _CoinGeckoApi;

  @GET('/coins/markets')
  Future<List<CoinMarketDto>> getMarketCoins({
    @Query('vs_currency') required String currency,
    @Query('order') required String order,
    @Query('per_page') required int perPage,
    @Query('page') required int page,
    @Query('sparkline') required bool sparkline,
  });

  @GET('/global')
  Future<GlobalMarketDto> getGlobalMarket();

  @GET('/search/trending')
  Future<TrendingCoinsResponseDto> getTrendingCoins();

  @GET('/coins/{id}')
  Future<CoinDetailDto> getCoinDetail({
    @Path('id') required String coinId,
    @Query('localization') required bool localization,
    @Query('tickers') required bool tickers,
    @Query('market_data') required bool marketData,
    @Query('community_data') required bool communityData,
    @Query('developer_data') required bool developerData,
  });

  @GET('/coins/{id}/market_chart')
  Future<CoinMarketChartDto> getCoinMarketChart({
    @Path('id') required String coinId,
    @Query('vs_currency') required String currency,
    @Query('days') required String days,
  });
}
