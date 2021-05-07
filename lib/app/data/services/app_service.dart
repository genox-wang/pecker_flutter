
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../utils/log.dart';

class AppService extends GetxService {
  static AppService get to => Get.find();

  late String tempDir;
  late String appDocDir;


  get appS => null;

  Future<AppService> init() async {
    sLog.e("AppService init");
    try {
      tempDir = (await getTemporaryDirectory()).path;
      appDocDir = (await getApplicationDocumentsDirectory()).path;
    } catch (e, _) {
      sLog.e("get dir error: ", e);
      // await Sentry.captureException(
      //   e,
      //   stackTrace: s,
      // );
    }

    sLog.e("tempDir $tempDir");
    sLog.e("appDocDir $appDocDir");

    return this;
  }
}
