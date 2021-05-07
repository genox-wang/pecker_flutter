import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class VibrationService extends GetxService {
  static VibrationService get to => Get.find();

  final _support = false.obs;
  bool get support => this._support.value;
  set support(bool value) => this._support.value = value;

  final _customSupport = false.obs;
  bool get customSupport => this._customSupport.value;
  set customSupport(bool value) => this._customSupport.value = value;

  final _amplitudeSupport = false.obs;
  bool get amplitudeSupport => this._amplitudeSupport.value;
  set amplitudeSupport(bool value) => this._amplitudeSupport.value = value;

  Future<VibrationService> init() async {
    support = await Vibration.hasVibrator() ?? false;
    customSupport = await Vibration.hasCustomVibrationsSupport() ?? false;
    amplitudeSupport = await Vibration.hasAmplitudeControl() ?? false;
    return this;
  }

  tapVibrate() {
    if (!support) return;
    // Vibration.cancel();
    if (customSupport) {
      if (amplitudeSupport) {
        Vibration.vibrate(pattern: [0, 10], intensities: [100]);
      } else {
        Vibration.vibrate(duration: 50);
      }
    } else {
      Vibration.vibrate();
    }
  }
}
