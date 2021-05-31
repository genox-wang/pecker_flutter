import 'package:get/get.dart';

import '../../../data/services/index.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    TaskService.to.contextGot.complete();
    super.onInit();
  }
}
