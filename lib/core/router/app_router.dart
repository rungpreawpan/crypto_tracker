import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/app_shell/presentation/view/app_shell_page.dart';
import '../../features/coin_detail/presentation/view/coin_detail_page.dart';
import '../../features/market/presentation/view/trending_coins_page.dart';
import '../../features/settings/presentation/view/currency_selection_page.dart';
import '../../features/settings/presentation/view/language_selection_page.dart';
import '../../features/settings/presentation/view/theme_selection_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'market',
        builder: (context, state) {
          return const AppShellPage();
        },
      ),
      GoRoute(
        path: '/coins/:id',
        name: 'coinDetail',
        builder: (context, state) {
          return CoinDetailPage(coinId: state.pathParameters['id'] ?? '');
        },
      ),
      GoRoute(
        path: '/markets/trending',
        name: 'trendingCoins',
        builder: (context, state) {
          return const TrendingCoinsPage();
        },
      ),
      GoRoute(
        path: '/settings/theme',
        name: 'themeSelection',
        builder: (context, state) {
          return const ThemeSelectionPage();
        },
      ),
      GoRoute(
        path: '/settings/language',
        name: 'languageSelection',
        builder: (context, state) {
          return const LanguageSelectionPage();
        },
      ),
      GoRoute(
        path: '/settings/currency',
        name: 'currencySelection',
        builder: (context, state) {
          return const CurrencySelectionPage();
        },
      ),
    ],
  );
});
