import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

/// 设备网络连接监听服务
/// 
/// ```
/// _connectivityWorker =
///   ever<ConnectivityResult>(ConnectivityService.to.rsStatus, (status) {
///     if (status == ConnectivityResult.none) {
///       close();
///     } else {
///       connect();
///     }
///   });
/// ...
/// _connectivityWorker.dispose();
/// ```
class ConnectivityService extends GetxService {
  static ConnectivityService get to => Get.find();

  StreamSubscription? _subscription;

  final rsStatus = Rx<ConnectivityResult>(ConnectivityResult.none);
  ConnectivityResult get status => this.rsStatus.value;
  set status(ConnectivityResult value) => this.rsStatus.value = value;

  Future<ConnectivityService> init() async {
    status = await (Connectivity().checkConnectivity());
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      status = result;
    });

    return this;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
