import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  final Connectivity connectivity;
  final InternetConnectionChecker connectionChecker;

  const NetworkInfo({
    required this.connectivity,
    required this.connectionChecker,
  });

  Future<bool> get isConnected async {
    final connectivityResults = await connectivity.checkConnectivity();
    final hasNetworkInterface = connectivityResults.any((result) {
      return result != ConnectivityResult.none;
    });

    if (!hasNetworkInterface) {
      return false;
    }

    return connectionChecker.hasConnection;
  }
}
