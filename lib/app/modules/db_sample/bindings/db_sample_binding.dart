import 'package:get/get.dart';

import '../controllers/db_sample_controller.dart';

class DbSampleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DbSampleController>(
      () => DbSampleController(),
    );
  }
}
