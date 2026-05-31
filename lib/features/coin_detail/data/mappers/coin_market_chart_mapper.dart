import '../../domain/entities/coin_price_point.dart';
import '../models/coin_market_chart_dto.dart';

class CoinMarketChartMapper {
  const CoinMarketChartMapper._();

  static List<CoinPricePoint> toEntity(CoinMarketChartDto dto) {
    return dto.prices.map((price) {
      return CoinPricePoint(
        timestamp: price[0].toInt(),
        price: price[1].toDouble(),
      );
    }).toList();
  }
}
