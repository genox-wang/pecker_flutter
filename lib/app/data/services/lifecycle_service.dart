import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LifecycleService extends GetxService with WidgetsBindingObserver {
  static LifecycleService get to => Get.find();

  final rxStatus = Rx<AppLifecycleState>(AppLifecycleState.resumed);
  AppLifecycleState get status => this.rxStatus.value;
  set status(AppLifecycleState value) => this.rxStatus.value = value;

  @override
  void onInit() {
    WidgetsBinding.instance?.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    status = state;
    super.didChangeAppLifecycleState(state);
  }
}
