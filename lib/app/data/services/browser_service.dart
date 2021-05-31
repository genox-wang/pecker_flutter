import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/app_pages.dart';

class BrowserService extends GetxService {
  static BrowserService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Future openAppBrowser(String url) async {
    await Get.toNamed(Routes.WEB_VIEW, arguments: {'url': url});
  }

  Future openSystemBrowser(String url) async {
    return launch(url);
  }
}
