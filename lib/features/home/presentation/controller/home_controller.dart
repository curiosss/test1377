import 'package:get/get.dart';

enum HomePageState {
  initial,
  loading,
  noInternet,
  webview,
  stub,
}

class HomeController {
  Rx<HomePageState> homeState = HomePageState.initial.obs;
  String webUrl = '';

  HomeController() {
    init();
  }

  init() async {
    return (false, '');
  }
}
