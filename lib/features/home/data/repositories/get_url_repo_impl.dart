import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:test1377/core/errors/errors.dart';
import 'package:test1377/core/local_storage/storage_hive.dart';
import 'package:test1377/features/home/domain/repositories/get_url_repo.dart';

class GetUrlRepoImpl implements GetUrlRepo {
  StorageHive storageHive = Get.find<StorageHive>();

  @override
  Future<(KError?, String)> getUrl() async {
    String? remoteUrl = storageHive.box?.get('remoteUrl');
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
      return (null, remoteUrl);
    }
    return getUrlFromFirebaseRemConf();
  }

  getUrlFromFirebaseRemConf() async {
    try {
      String url = FirebaseRemoteConfig.instance.getString('app_remote_url');
      if (url.isNotEmpty) {
        storageHive.box?.put('remoteUrl', url);
      }
      return (null, url);
    } catch (e) {
      log(e.toString());
      return (NoInternet, '');
    }
  }
}
