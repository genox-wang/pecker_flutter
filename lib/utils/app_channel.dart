import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AppChannel {
  static final MethodChannel channel = MethodChannel("pecker_flutter");

  static StreamController<void> _onIOSResumeController =
      StreamController<void>.broadcast();

  static Stream<void> onIOSResume = _onIOSResumeController.stream;

  static StreamController<void> _onIOSPauseController =
      StreamController<void>.broadcast();

  static Stream<void> onIOSPause = _onIOSPauseController.stream;

  static init() {
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'ios_pause':
          _onIOSPauseController.add(null);
          break;
        case 'ios_resume':
          _onIOSResumeController.add(null);
          break;
      }
      return null;
    });
  }

  static dispose() {
    _onIOSResumeController.close();
    _onIOSPauseController.close();
  }

  static Future appReview() {
    if (Platform.isIOS) {
      return channel.invokeMethod("appReview");
    }
    return Future.error('appReview only support IOS');
  }

  static Future quickAppReview() {
    if (Platform.isIOS) {
      return channel.invokeMethod("quickAppReview");
    }
    return Future.error('quickAppReview only support IOS');
  }

  static Future requestIDFA() {
    if (Platform.isIOS) {
      return channel.invokeMethod("requestIDFA");
    }
    return Future.error('requestIDFA only support IOS');
  }
}
