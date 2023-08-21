import 'dart:developer';
import 'package:get/get.dart';
import 'package:test1377/core/errors/errors.dart';
import 'package:test1377/core/local_storage/storage_hive.dart';
import 'package:test1377/core/network/connectivity_info.dart';
import 'package:test1377/core/services/firebase_remote_config.dart';
import 'package:test1377/features/home/domain/repositories/get_url_repo.dart';

class GetUrlRepoImpl implements GetUrlRepo {
  StorageHive storageHive = Get.find<StorageHive>();
  ConnectivityInfo connectivityInfo = Get.find<ConnectivityInfo>();
  FirebaseRemConfService firebaseRemConfService =
      Get.find<FirebaseRemConfService>();

  @override
  Future<(KError? err, String url)> getUrl() async {
    String? remoteUrl = storageHive.box?.get('remoteUrl');
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      if (!await connectivityInfo.isConnected()) {
        return (
          NoInternet(
            message: 'The application requires access to the network',
          ),
          ''
        );
      }
      return (null, remoteUrl);
    }
    return getUrlFromFirebaseRemConf();
  }

  Future<(KError? err, String url)> getUrlFromFirebaseRemConf() async {
    try {
      // String url = FirebaseRemoteConfig.instance.getString('app_remote_url');
      String url =
          firebaseRemConfService.remoteConfig.getString('app_remote_url');
      if (url.isNotEmpty) {
        storageHive.box?.put('remoteUrl', url);
      }
      return (null, url);
    } catch (e) {
      log(e.toString());
      return (
        NoInternet(
          message: 'The application requires access to the network',
        ),
        ''
      );
    }
  }
}
