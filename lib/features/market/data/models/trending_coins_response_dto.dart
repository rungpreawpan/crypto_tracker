import 'trending_coin_dto.dart';

class TrendingCoinsResponseDto {
  final List<TrendingCoinDto> coins;

  const TrendingCoinsResponseDto({required this.coins});

  factory TrendingCoinsResponseDto.fromJson(Map<String, dynamic> json) {
    final coinItems = json['coins'];

    if (coinItems is! List) {
      return const TrendingCoinsResponseDto(coins: []);
    }

    return TrendingCoinsResponseDto(
      coins: coinItems.map((item) {
        return TrendingCoinDto.fromJson(Map<String, dynamic>.from(item as Map));
      }).toList(),
    );
  }
}
