import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';

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
