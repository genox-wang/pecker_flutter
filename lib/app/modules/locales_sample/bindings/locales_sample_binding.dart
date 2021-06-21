import 'package:get/get.dart';

import '../controllers/locales_sample_controller.dart';

class LocalesSampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalesSampleController>(
      () => LocalesSampleController(),
    );
  }
}
