import 'package:get/get.dart';

import '../databases/app_db.dart';

/// 数据服务
///
/// ```
/// final gameBoard = await DbService.to.db.gameBoardsDao
///   .getOne(battleGameInfo.boardId);
/// ```
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
