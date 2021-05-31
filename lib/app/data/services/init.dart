import 'package:get/get.dart';

import '../../modules/splash/controllers/splash_controller.dart';
import 'app_trace_service.dart';
import 'index.dart';

Future initServices() async {
  Get.put(AppTraceService());
  Get.put(TaskService()..init());
  Get.put(LifecycleService());
  await Get.putAsync(() => ConnectivityService().init());
  await Get.putAsync(() => HttpService().init());
  await Get.putAsync(() => AppUpgraderService().init());
  Get.put(WebSocketService());
  Get.put(DbService());
  await Get.putAsync(() => AppService().init());
  await Get.putAsync(() => VibrationService().init());

  Get.lazyPut(() => ImagePickerService());
  Get.lazyPut(() => BrowserService());

  SplashController.to.allServicesReady.value = true;
}
