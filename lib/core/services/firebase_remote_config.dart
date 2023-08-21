import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemConfService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(
          seconds: 1,
        ), // a fetch will wait up to 10 seconds before timing out
        minimumFetchInterval: const Duration(
          seconds: 10,
        ),
      ));
      await remoteConfig.fetchAndActivate();
      return;
    } catch (e) {
      log(e.toString());
    }
  }
}
