class CoinMarketChartDto {
  final List<List<num>> prices;

  const CoinMarketChartDto({required this.prices});

  factory CoinMarketChartDto.fromJson(Map<String, dynamic> json) {
    final rawPrices = json['prices'];

    if (rawPrices is! List) {
      return const CoinMarketChartDto(prices: []);
    }

    return CoinMarketChartDto(
      prices: rawPrices.map((item) {
        if (item is! List || item.length < 2) {
          return <num>[0, 0];
        }

        return <num>[
          item[0] is num ? item[0] as num : 0,
          item[1] is num ? item[1] as num : 0,
        ];
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'prices': prices};
  }
}
