import 'package:flutter/material.dart';
import 'package:test1377/features/home/presentation/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = HomeController();

  @override
  void initState() {
    fetch();
    super.initState();
  }

  fetch() async {
    var data = await homeController.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text('data'),
    );
  }
}
