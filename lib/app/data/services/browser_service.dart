import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/app_pages.dart';

/// 浏览器服务
class BrowserService extends GetxService {
  static BrowserService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  /// 应用内打开链接
  Future openAppBrowser(String url) async {
    await Get.toNamed(Routes.WEB_VIEW, arguments: {'url': url});
  }

  /// 系统浏览器打开链接
  Future openSystemBrowser(String url) async {
    return launch(url);
  }
}
