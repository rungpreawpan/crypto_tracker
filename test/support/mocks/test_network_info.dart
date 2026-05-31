import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto_tracker/core/network/network_info.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class TestNetworkInfo extends NetworkInfo {
  final bool connected;

  TestNetworkInfo(this.connected)
    : super(
        connectivity: Connectivity(),
        connectionChecker: InternetConnectionChecker.instance,
      );

  @override
  Future<bool> get isConnected async {
    return connected;
  }
}
