import 'package:get/get.dart';

import '../controllers/web_view_controller.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewController>(
      () => WebViewController(),
    );
  }
}
