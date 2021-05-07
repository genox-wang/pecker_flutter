import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MyPageViewController extends GetxController {
  PageController controller = PageController();

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  final _index = 0.obs;
  get index => this._index.value;
  set index(value) => this._index.value = value;
}
