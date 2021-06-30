import 'dart:async';

import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

class VibrationService extends GetxService {
  static VibrationService get to => Get.find();

  final _support = false.obs;
  bool get support => this._support.value;
  set support(bool value) => this._support.value = value;

  Future<VibrationService> init() async {
    support = await Vibrate.canVibrate;
    return this;
  }

  onClose() {
    _thottleTimer?.cancel();
    super.onClose();
  }

  Timer? _thottleTimer;

  tapVibrate() {
    if (_thottleTimer?.isActive == true) {
      return;
    }
    _thottleTimer = Timer(Duration(milliseconds: 300), () {});
    if (!support) return;

    Vibrate.feedback(FeedbackType.light);
  }
}
