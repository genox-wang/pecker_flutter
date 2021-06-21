import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/index.dart';
import 'websocket_service.dart';

/// 应用生命周期监听服务
///
/// ```
/// _lifecycleWorker =
///   ever<AppLifecycleState>(LifecycleService.to.rxStatus, (status) {
///     if (status == AppLifecycleState.resumed) {
///       ...
///   }
/// });
/// ...
/// _lifecycleWorker.dispose();
/// ```
class LifecycleService extends GetxService with WidgetsBindingObserver {
  static LifecycleService get to => Get.find();

  final rxStatus = Rx<AppLifecycleState>(AppLifecycleState.resumed);
  AppLifecycleState get status => this.rxStatus.value;
  set status(AppLifecycleState value) => this.rxStatus.value = value;

  final rxIosState = Rx<IOSLifecycleState>(IOSLifecycleState.resume);
  IOSLifecycleState get iosState => this.rxIosState.value;
  set iosState(IOSLifecycleState value) => this.rxIosState.value = value;

  // 上一次退到后台的时间
  DateTime? lastPauseTime;

  StreamSubscription? appChannelSub;

  @override
  void onInit() {
    WidgetsBinding.instance?.addObserver(this);
    if (Platform.isIOS) {
      appChannelSub = AppChannel.onEvent.listen((event) {
        if (event.type == AppChannelEventType.IOS_PAUSE) {
          WebSocketService.to.onPause();
          iosState = IOSLifecycleState.pause;
        } else if (event.type == AppChannelEventType.IOS_RESUME) {
          WebSocketService.to.onResume();
          iosState = IOSLifecycleState.resume;
        }
      });
    }
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    appChannelSub?.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    status = state;
    super.didChangeAppLifecycleState(state);
  }
}

enum IOSLifecycleState {
  resume,
  pause,
}
