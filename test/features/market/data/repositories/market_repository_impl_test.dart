import 'package:crypto_tracker/core/error/app_exception.dart';
import 'package:crypto_tracker/features/market/data/models/coin_market_dto.dart';
import 'package:crypto_tracker/features/market/data/repositories/market_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../support/mocks/mock_market_local_data_source.dart';
import '../../../../support/mocks/mock_market_remote_data_source.dart';
import '../../../../support/mocks/test_network_info.dart';

void main() {
  late MockMarketRemoteDataSource remoteDataSource;
  late MockMarketLocalDataSource localDataSource;

  setUp(() {
    remoteDataSource = MockMarketRemoteDataSource();
    localDataSource = MockMarketLocalDataSource();
  });

  test('returns remote market coins and saves cache when online fetch succeeds', () async {
    final remoteCoins = [_coinMarketDto(id: 'bitcoin', currentPrice: 100.0)];
    final repository = MarketRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: TestNetworkInfo(true),
    );

    when(() {
      return remoteDataSource.getMarketCoins(page: 1, currencyCode: 'usd');
    }).thenAnswer((_) async {
      return remoteCoins;
    });
    when(() {
      return localDataSource.saveMarketCoins(
        page: 1,
        currencyCode: 'usd',
        coins: remoteCoins,
      );
    }).thenAnswer((_) async {});

    final result = await repository.getMarketCoins(
      page: 1,
      currencyCode: 'usd',
      forceRefresh: false,
    );

    expect(result, hasLength(1));
    expect(result.first.id, 'bitcoin');
    verify(() {
      return remoteDataSource.getMarketCoins(page: 1, currencyCode: 'usd');
    }).called(1);
    verify(() {
      return localDataSource.saveMarketCoins(
        page: 1,
        currencyCode: 'usd',
        coins: remoteCoins,
      );
    }).called(1);
  });

  test('falls back to cached market coins when remote fetch fails', () async {
    final cachedCoins = [_coinMarketDto(id: 'ethereum', currentPrice: 200.0)];
    final repository = MarketRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: TestNetworkInfo(true),
    );

    when(() {
      return remoteDataSource.getMarketCoins(page: 1, currencyCode: 'usd');
    }).thenThrow(Exception('network failed'));
    when(() {
      return localDataSource.getMarketCoins(page: 1, currencyCode: 'usd');
    }).thenReturn(cachedCoins);

    final result = await repository.getMarketCoins(
      page: 1,
      currencyCode: 'usd',
      forceRefresh: false,
    );

    expect(result, hasLength(1));
    expect(result.first.id, 'ethereum');
    verify(() {
      return localDataSource.getMarketCoins(page: 1, currencyCode: 'usd');
    }).called(1);
  });

  test('throws localized cache error when offline and no cached data exists', () async {
    final repository = MarketRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: TestNetworkInfo(false),
    );

    when(() {
      return localDataSource.getMarketCoins(page: 1, currencyCode: 'usd');
    }).thenReturn([]);

    expect(
      () {
        return repository.getMarketCoins(
          page: 1,
          currencyCode: 'usd',
          forceRefresh: false,
        );
      },
      throwsA(
        isA<AppException>().having((error) {
          return error.message;
        }, 'message', 'errors.market_cache_unavailable'),
      ),
    );
  });
}

CoinMarketDto _coinMarketDto({
  required String id,
  required num currentPrice,
}) {
  return CoinMarketDto(
    id: id,
    symbol: id.substring(0, 3),
    name: id,
    image: 'https://example.com/$id.png',
    currentPrice: currentPrice,
    marketCap: currentPrice * 1000.0,
    marketCapRank: 1,
    priceChangePercentage24h: 2.5,
    sparklinePrices: const [1.0, 2.0, 3.0],
  );
}
