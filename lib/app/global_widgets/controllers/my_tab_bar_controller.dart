import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MyTabBarController extends GetxController {
  MyTabBarController({
    required List<String> tabs,
    required TickerProvider vsync,
  }) {
    controller = TabController(length: tabs.length, vsync: vsync);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  late TabController controller;

  final List<String> tabs = <String>[].obs;
}
