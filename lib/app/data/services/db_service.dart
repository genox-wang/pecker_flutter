import 'package:get/get.dart';

import '../databases/app_db.dart';

class DbService extends GetxService {
  static DbService get to => Get.find();

  late AppDb db;

  @override
  void onInit() {
    db = AppDb();
    super.onInit();
  }

  @override
  void onClose() {
    db.close();
    super.onClose();
  }
}
