import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1377/features/home/presentation/controller/home_controller.dart';
import 'package:test1377/features/home/presentation/pages/error_page.dart';
import 'package:test1377/features/home/presentation/pages/main_view.dart';
import 'package:test1377/features/tetris/presentation/pages/tetris_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();

  @override
  void initState() {
    controller.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          switch (controller.homeState.value) {
            case HomePageState.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case HomePageState.webview:
              return MainView(r: controller.webUrl);
            case HomePageState.error:
              return ErrorPage(
                kError: controller.kError!,
                onRefresh: controller.getData,
              );

            case HomePageState.stub:
              // return const StubPage();
              return const TetrisPage();
            default:
              return Container();
          }
        }),
      ),
    );
  }
}
