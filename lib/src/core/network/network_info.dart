import 'package:connectivity_plus/connectivity_plus.dart';

/// Interface for checking network connectivity
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of NetworkInfo using connectivity_plus
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  bool? _lastConnectivityResult;
  DateTime? _lastCheckTime;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // Son 5 saniye içinde kontrol edildiyse cache'den döndür
    final now = DateTime.now();
    if (_lastCheckTime != null &&
        now.difference(_lastCheckTime!).inSeconds < 5 &&
        _lastConnectivityResult != null) {
      return _lastConnectivityResult!;
    }

    try {
      final connectivityResult = await connectivity.checkConnectivity();
      final isConnected = connectivityResult != ConnectivityResult.none;

      // Cache'le
      _lastConnectivityResult = isConnected;
      _lastCheckTime = now;

      return isConnected;
    } catch (e) {
      // Hata durumunda cache'den döndür veya false
      return _lastConnectivityResult ?? false;
    }
  }
}
