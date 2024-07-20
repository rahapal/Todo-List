import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  ConnectivityUtils._();
  static ConnectivityUtils? _utils;

  static ConnectivityUtils get instance {
    _utils ??= ConnectivityUtils._();
    return _utils!;
  }

  Future<bool> get hasInternet async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
        return true;
      } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("$e");
      return false;
    }
  }
}
