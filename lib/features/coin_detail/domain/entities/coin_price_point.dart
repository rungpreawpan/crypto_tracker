import 'package:equatable/equatable.dart';

class CoinPricePoint extends Equatable {
  final int timestamp;
  final double price;

  const CoinPricePoint({required this.timestamp, required this.price});

  @override
  List<Object?> get props {
    return [timestamp, price];
  }
}
