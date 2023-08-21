import 'package:get/get.dart';
import 'package:test1377/core/errors/errors.dart';

import 'package:test1377/features/home/data/repositories/get_url_repo_impl.dart';
import 'package:test1377/features/home/domain/use_cases/get_url_use_case.dart';

enum HomePageState {
  initial,
  loading,
  error,
  webview,
  stub,
}

class HomeController {
  late GetUrlRepoImpl getUrlRepoImpl;
  late GetUrlUseCase getUrlUseCase;
  HomeController() {
    getUrlRepoImpl = GetUrlRepoImpl();
    getUrlUseCase = GetUrlUseCase(repo: getUrlRepoImpl);
  }

  Rx<HomePageState> homeState = HomePageState.initial.obs;
  String webUrl = '';
  KError? kError;

//TODO
  // Future<(KError? err, String url, bool showStub)>
  getData() async {
    // kError = NoInternet();
    // homeState.value = HomePageState.error;
    // return;
    // var data = await getUrlUseCase.getData();
    // return data;

    homeState.value = HomePageState.loading;
    var data = await getUrlUseCase.getData();
    print(data);
    if (data.$1 != null) {
      kError = data.$1;
      homeState.value = HomePageState.error;
      return;
    }
    if (data.$3) {
      homeState.value = HomePageState.stub;
      return;
    }
    if (data.$2.isNotEmpty) {
      webUrl = data.$2;
      homeState.value = HomePageState.webview;
      return;
    }

    homeState.value = HomePageState.initial;
  }
}
