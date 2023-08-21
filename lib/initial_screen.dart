import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:test1377/core/local_storage/storage_hive.dart';
import 'package:test1377/features/home/presentation/pages/home_page.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isloading = true;

  @override
  void initState() {
    initDependencies();
    super.initState();
  }

  initDependencies() async {
    try {
      StorageHive storageHive = StorageHive();
      await storageHive.init();
      Get.put(storageHive);

      // FirebaseRemConfService firebaseRemConfService = FirebaseRemConfService();
      // await firebaseRemConfService.init();
      // Get.put(firebaseRemConfService);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isloading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return const HomePage();
  }
}
