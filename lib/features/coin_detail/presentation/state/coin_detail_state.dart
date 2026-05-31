import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/coin_detail.dart';

part 'coin_detail_state.freezed.dart';

@freezed
sealed class CoinDetailState with _$CoinDetailState {
  const factory CoinDetailState({
    required CoinDetail? coin,
    required bool isFavorite,
    required bool isOffline,
  }) = CoinDetailStateData;

  factory CoinDetailState.initial() {
    return const CoinDetailState(
      coin: null,
      isFavorite: false,
      isOffline: false,
    );
  }
}
