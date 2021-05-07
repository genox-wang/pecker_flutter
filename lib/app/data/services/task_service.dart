import 'dart:async';

import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';

/// 任务服务，用于让线型任务依次执行
/// 比如多个弹出框同时弹出，为了防止弹框叠弹窗，可以让一个弹窗任务结束再打开下一个
class TaskService extends GetxService {
  static TaskService get to => Get.find();

  final _dialogLock = Lock();

  init() async {
    // 保证任务开始执行的时候 context 已经获得
    await doTask(() {
      Completer contextGot = Completer();
      Timer.periodic(Duration(milliseconds: 100), (timer) {
        if (Get.context != null) {
          timer.cancel();
          contextGot.complete();
        }
      });
      return contextGot.future;
    });
  }

  Future doTask(Future Function() task, {Lock? lock}) {
    final _lock = lock ?? _dialogLock;
    return _lock.synchronized(task);
  }

  Future showDialog(Future Function() show) {
    return doTask(show);
  }
}
