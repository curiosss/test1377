import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityInfo {
  Connectivity connectivity = Connectivity();

  Future<bool> isConnected({showMessage = true}) async {
    final result = await connectivity.checkConnectivity();
    if (result != ConnectivityResult.none) {
      return true;
    }
    return false;
  }
}
