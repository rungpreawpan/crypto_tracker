import 'package:crypto_tracker/core/di/core_providers.dart';
import 'package:crypto_tracker/features/market/domain/entities/global_market.dart';
import 'package:crypto_tracker/features/market/domain/entities/market_coin.dart';
import 'package:crypto_tracker/features/market/domain/entities/trending_coin.dart';
import 'package:crypto_tracker/features/market/presentation/providers/market_providers.dart';
import 'package:crypto_tracker/features/settings/presentation/providers/currency_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../support/mocks/fake_market_repository.dart';
import '../../../../support/mocks/test_currency_view_model.dart';
import '../../../../support/mocks/test_network_info.dart';

void main() {
  test('build loads market state with market data, trending data, and offline flag', () async {
    final container = _container(
      repository: FakeMarketRepository(
        globalMarket: _globalMarket(),
        trendingCoins: [_trendingCoin()],
        marketCoinsByPage: {
          1: [_marketCoin(id: 'bitcoin', name: 'Bitcoin')],
        },
      ),
      connected: false,
    );

    addTearDown(container.dispose);

    final state = await container.read(marketViewModelProvider.future);

    expect(state.globalMarket, isNotNull);
    expect(state.trendingCoins, hasLength(1));
    expect(state.coins, hasLength(1));
    expect(state.filteredCoins, hasLength(1));
    expect(state.isOffline, isTrue);
    expect(state.hasReachedEnd, isTrue);
  });

  test('loadNextPage appends next page and updates end state', () async {
    final container = _container(
      repository: FakeMarketRepository(
        globalMarket: _globalMarket(),
        trendingCoins: [_trendingCoin()],
        marketCoinsByPage: {
          1: _marketCoinsPage(),
          2: [_marketCoin(id: 'ethereum', name: 'Ethereum')],
        },
      ),
      connected: true,
    );

    addTearDown(container.dispose);

    await container.read(marketViewModelProvider.future);
    await container.read(marketViewModelProvider.notifier).loadNextPage();

    final state = container.read(marketViewModelProvider).requireValue;

    expect(state.currentPage, 2);
    expect(state.coins, hasLength(21));
    expect(state.coins.last.id, 'ethereum');
    expect(state.hasReachedEnd, isTrue);
  });

  test('updateSearchQuery filters visible coins after debounce', () async {
    final container = _container(
      repository: FakeMarketRepository(
        globalMarket: _globalMarket(),
        trendingCoins: [_trendingCoin()],
        marketCoinsByPage: {
          1: [
            _marketCoin(id: 'bitcoin', name: 'Bitcoin'),
            _marketCoin(id: 'ethereum', name: 'Ethereum'),
          ],
        },
      ),
      connected: true,
    );

    addTearDown(container.dispose);

    await container.read(marketViewModelProvider.future);
    container.read(marketViewModelProvider.notifier).updateSearchQuery('eth');
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final state = container.read(marketViewModelProvider).requireValue;

    expect(state.searchQuery, 'eth');
    expect(state.filteredCoins, hasLength(1));
    expect(state.filteredCoins.first.id, 'ethereum');
  });
}

ProviderContainer _container({
  required FakeMarketRepository repository,
  required bool connected,
}) {
  return ProviderContainer(
    overrides: [
      marketRepositoryProvider.overrideWithValue(repository),
      networkInfoProvider.overrideWithValue(TestNetworkInfo(connected)),
      appCurrencyProvider.overrideWith(() {
        return TestCurrencyViewModel();
      }),
    ],
  );
}

GlobalMarket _globalMarket() {
  return const GlobalMarket(
    activeCryptocurrencies: 10000,
    markets: 1000,
    totalMarketCapUsd: 1000000.0,
    totalVolumeUsd: 500000.0,
    btcMarketCapPercentage: 52.0,
    marketCapChangePercentage24hUsd: 1.2,
  );
}

TrendingCoin _trendingCoin() {
  return const TrendingCoin(
    id: 'solana',
    name: 'Solana',
    symbol: 'SOL',
    image: 'https://example.com/sol.png',
    marketCapRank: 5,
    price: 150.0,
    priceChangePercentage24h: 6.4,
  );
}

MarketCoin _marketCoin({
  required String id,
  required String name,
}) {
  return MarketCoin(
    id: id,
    symbol: id.substring(0, 3),
    name: name,
    image: 'https://example.com/$id.png',
    currentPrice: 100.0,
    marketCap: 1000000.0,
    marketCapRank: 1,
    priceChangePercentage24h: 2.5,
    sparklinePrices: const [1.0, 2.0, 3.0],
  );
}

List<MarketCoin> _marketCoinsPage() {
  return List<MarketCoin>.generate(20, (index) {
    return _marketCoin(
      id: 'coin_$index',
      name: 'Coin $index',
    );
  });
}
