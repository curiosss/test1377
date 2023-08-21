import 'package:get/instance_manager.dart';
import 'package:test1377/core/local_storage/storage_hive.dart';

class HomeController {
  StorageHive storageHive = Get.find<StorageHive>();

  Future<(bool, String)> fetch() async {
    String? remoteUrl = storageHive.box?.get('remoteUrl');
    if (remoteUrl != null && remoteUrl.isNotEmpty) {
    } else {}

    return (false, '');
  }

  connectFirebaseRemConf() async {}

  Future<bool> isEmulator() async {
    return false;
  }
}
