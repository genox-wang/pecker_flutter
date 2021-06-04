import 'dart:async';

import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';

/// 任务服务，用于让线型任务依次执行
/// 比如多个弹出框同时弹出，为了防止弹框叠弹窗，可以让一个弹窗任务结束再打开下一个
class TaskService extends GetxService {
  static TaskService get to => Get.find();

  final _dialogLock = Lock();
  Completer contextGot = Completer();

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    // contextGot 会在 HomeController.onInit complete
    // 这样可以保证所有的任务会在到达住界面再开始执行
    await doTask(
      () => contextGot.future,
      // 等待 home 任务用不超时
      timeout: Duration(
        hours: 10,
      ),
    );
  }

  Future doTask(Future Function() task, {Lock? lock, Duration? timeout}) {
    final _lock = lock ?? _dialogLock;
    return _lock.synchronized(() => task());
  }

  Future showDialog(Future Function() show) {
    return doTask(show);
  }
}
