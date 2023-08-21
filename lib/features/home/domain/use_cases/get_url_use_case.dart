import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:test1377/core/errors/errors.dart';
import 'package:test1377/features/home/domain/repositories/get_url_repo.dart';

class GetUrlUseCase {
  final GetUrlRepo repo;
  GetUrlUseCase({required this.repo});

  Future<(KError? err, String url, bool showStub)> getData() async {
    var data = await repo.getUrl();
    if (data.$1 != null) {
      return (data.$1, '', false);
    }
    if (data.$2.isNotEmpty) {
      return (null, data.$2, false);
    } else if (await checkIsEmu()) {
      return (null, '', true);
    }
    return (null, '', false);
  }

  checkIsEmu() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final em = await deviceInfo.androidInfo;
      var phoneModel = em.model;
      var buildProduct = em.product;
      var buildHardware = em.hardware;
      var result = (em.fingerprint.startsWith("generic") ||
          phoneModel.contains("google_sdk") ||
          phoneModel.contains("droid4x") ||
          phoneModel.contains("Emulator") ||
          phoneModel.contains("Android SDK built for x86") ||
          em.manufacturer.contains("Genymotion") ||
          buildHardware == "goldfish" ||
          buildHardware == "vbox86" ||
          buildProduct == "sdk" ||
          buildProduct == "google_sdk" ||
          buildProduct == "sdk_x86" ||
          buildProduct == "vbox86p" ||
          em.brand.contains('google') ||
          em.board.toLowerCase().contains("nox") ||
          em.bootloader.toLowerCase().contains("nox") ||
          buildHardware.toLowerCase().contains("nox") ||
          !em.isPhysicalDevice ||
          buildProduct.toLowerCase().contains("nox"));
      if (result) return true;
      result = result ||
          (em.brand.startsWith("generic") && em.device.startsWith("generic"));
      if (result) return true;
      result = result || ("google_sdk" == buildProduct);
      return result;
    } else if (Platform.isIOS) {
      final em = await deviceInfo.iosInfo;
      return !em.isPhysicalDevice;
    }
    return false;
  }
}
