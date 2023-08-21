import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1377/features/home/presentation/controller/home_controller.dart';
import 'package:test1377/features/home/presentation/pages/error_page.dart';
import 'package:test1377/features/home/presentation/pages/webview_page.dart';
import 'package:test1377/features/stub/presentation/pages/stub_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();
  @override
  Widget build(BuildContext context) {
    controller.getData();
    return SafeArea(
      child: Scaffold(
        // body: FutureBuilder(
        //   future: controller.getData(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(
        //         child: CircularProgressIndicator.adaptive(),
        //       );
        //     } else if (snapshot.hasData) {
        //       if (snapshot.data!.$1 != null) {
        //         return ErrorPage(
        //           kError: controller.kError!,
        //           onRefresh: controller.getData,
        //         );
        //       } else if (snapshot.data!.$3) {
        //         return WebViewPage(url: controller.webUrl);
        //       }
        //     }
        //     return Container();
        //   },
        // ),
        body: Obx(() {
          switch (controller.homeState.value) {
            case HomePageState.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case HomePageState.webview:
              return WebViewPage(url: controller.webUrl);
            case HomePageState.error:
              return ErrorPage(
                kError: controller.kError!,
                onRefresh: controller.getData,
              );

            case HomePageState.stub:
              return const StubPage();
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
