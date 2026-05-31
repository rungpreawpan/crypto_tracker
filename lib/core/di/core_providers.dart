import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constants/api_constants.dart';
import '../constants/local_storage_keys.dart';
import '../network/network_info.dart';

final dioProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 12),
    receiveTimeout: const Duration(seconds: 12),
  );

  return Dio(options);
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfo(
    connectivity: Connectivity(),
    connectionChecker: InternetConnectionChecker.instance,
  );
});

final marketCacheBoxProvider = Provider<Box<Map>>((ref) {
  return Hive.box<Map>(LocalStorageKeys.marketCacheBox);
});

final coinDetailCacheBoxProvider = Provider<Box<Map>>((ref) {
  return Hive.box<Map>(LocalStorageKeys.coinDetailCacheBox);
});

final favoriteCoinBoxProvider = Provider<Box<String>>((ref) {
  return Hive.box<String>(LocalStorageKeys.favoriteCoinBox);
});

final settingsBoxProvider = Provider<Box<String>>((ref) {
  return Hive.box<String>(LocalStorageKeys.settingsBox);
});
