import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final T = () => AppTraceService.to;

class AppTraceService extends GetxService {
  static AppTraceService get to => Get.find();

  @override
  onClose() {
    super.onClose();
  }

  event(String event) {
    if (!kReleaseMode) {
      return;
    }
    Sentry.captureMessage(event);
  }

  error(Object e, [StackTrace? s]) {
    if (!kReleaseMode) {
      return;
    }
    Sentry.captureException(e, stackTrace: s);
  }

  pageStart(String page) {
    if (!kReleaseMode) {
      return;
    }
  }

  pageEnd(String page) {
    if (!kReleaseMode) {
      return;
    }
  }
}
