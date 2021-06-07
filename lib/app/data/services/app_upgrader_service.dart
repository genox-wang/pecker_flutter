import 'package:get/get.dart';

import '../../../utils/index.dart';
import 'index.dart';

part 'mixins/app_upgrader_infos_mixin.dart';

/// 应用更新服务
class AppUpgraderService extends GetxService {
  static AppUpgraderService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future<AppUpgraderService> init() async {
    TaskService.to.doTask(() => tryShowUpgraderInfo());
    return this;
  }

  /// 展示当前版本的更新内容
  Future tryShowUpgraderInfo() async {
    final buildNumber = AppService.to.buildNumber;
    final version = AppService.to.version;

    if (buildNumber != null) {
      if (S().getIsUpgradeInfoShowed(buildNumber)) {
        return;
      }
      S().setIsUpgradeInfoShowed(buildNumber, true);
      if (_infos['${buildNumber ~/ 100}'] != null) {
        await MyUI.showDefaultDialog(
            title: 'v $version 更新内容',
            body: _infos['${buildNumber ~/ 100}']!,
            confirmText: '知道了',
            barrierDismissible: false);
      }
    }
  }
}
