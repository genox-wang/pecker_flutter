import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/index.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();

  Rx<bool> allServicesReady = Rx<bool>(false);

  late DateTime startTime;

  final showTime = 500;

  @override
  void onInit() {
    startTime = DateTime.now();
    ever<bool>(allServicesReady, (ready) {
      if (ready) {
        final diff = DateTime.now().difference(startTime);
        if (diff.inMilliseconds > showTime) {
          close();
        } else {
          Timer(Duration(milliseconds: showTime - diff.inMilliseconds), () {
            close();
          });
        }
      }
    });
    super.onInit();
  }

  close() {
    Get.offNamed(Routes.HOME);
  }
}
