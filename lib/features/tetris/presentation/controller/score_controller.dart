import 'package:get/get.dart';
import 'package:test1377/core/local_storage/storage_hive.dart';

class ScoreController {
  RxInt highScore = 0.obs;
  RxInt totalScore = 0.obs;

  ScoreController() {
    init();
  }

  StorageHive storageHive = Get.find<StorageHive>();

  init() {
    highScore.value = storageHive.box?.get('highScore') ?? 0;
  }

  updateScore(int sc) {
    totalScore.value = sc;
    if (sc > highScore.value) {
      highScore.value = sc;
      storageHive.box?.put('highScore', sc);
    }
  }
}
