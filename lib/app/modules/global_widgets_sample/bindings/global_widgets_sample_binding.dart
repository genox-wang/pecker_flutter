import 'package:get/get.dart';

import '../controllers/global_widgets_sample_controller.dart';

class GlobalWidgetsSampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalWidgetsSampleController>(
      () => GlobalWidgetsSampleController(),
    );
  }
}
