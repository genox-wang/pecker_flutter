import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

// 应用与原生的交互的通道
class AppChannel {
  static final MethodChannel channel = MethodChannel("pecker_flutter");

  static StreamController<AchEvent> _eventController =
      StreamController<AchEvent>.broadcast();

  static Stream<AchEvent> onEvent = _eventController.stream;

  static init() {
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'ios_pause':
          _eventController.add(AchEvent(type: AchEventType.IOS_PAUSE));
          break;
        case 'ios_resume':
          _eventController.add(AchEvent(type: AchEventType.IOS_RESUME));
          break;
      }
      return null;
    });
  }

  static dispose() {
    _eventController.close();
  }

  // ios 应用市场好评
  static Future appReview() {
    if (Platform.isIOS) {
      return channel.invokeMethod("appReview");
    }
    return Future.error('appReview only support IOS');
  }

  // ios 快速好评, 每个用户一年可以弹出三次
  static Future quickAppReview() {
    if (Platform.isIOS) {
      return channel.invokeMethod("quickAppReview");
    }
    return Future.error('quickAppReview only support IOS');
  }

  // ios 使用广告前需要申请 IDFA 权限
  static Future requestIDFA() {
    if (Platform.isIOS) {
      return channel.invokeMethod("requestIDFA");
    }
    return Future.error('requestIDFA only support IOS');
  }
}

// AppChannel 事件
enum AchEventType {
  IOS_RESUME,
  IOS_PAUSE,
}

class AchEvent {
  final AchEventType type;
  final dynamic? value;

  AchEvent({required this.type, this.value});
}
