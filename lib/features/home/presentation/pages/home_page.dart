import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1377/features/home/presentation/controller/home_controller.dart';
import 'package:test1377/features/home/presentation/pages/webview_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = HomeController();
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          switch (controller.homeState.value) {
            case HomePageState.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case HomePageState.webview:
              return WebViewPage(url: controller.webUrl);
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
