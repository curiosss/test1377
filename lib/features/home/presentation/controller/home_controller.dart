import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:test1377/core/local_storage/storage_hive.dart';

enum HomePageState {
  initial,
  loading,
  noInternet,
  webview,
  stub,
}

class HomeController {
  StorageHive storageHive = Get.find<StorageHive>();

  Rx<HomePageState> homeState = HomePageState.initial.obs;
  String webUrl = '';

  HomeController() {
    init();
  }

  init() async {
    String? remoteUrl = storageHive.box?.get('remoteUrl');
    homeState.value = HomePageState.loading;
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
    } else {
      await connectFirebaseRemConf();
    }

    return (false, '');
  }

  connectFirebaseRemConf() async {
    String url = FirebaseRemoteConfig.instance.getString('app_remote_url');
    if (url.isNotEmpty) {}
  }

  Future<bool> isEmulator() async {
    return false;
  }
}
