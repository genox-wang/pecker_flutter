import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/data/services/index.dart';
import 'config.dart';

import 'app.dart';
import 'app/data/services/init.dart';

void main() async {
  final run = () async {
    WidgetsFlutterBinding.ensureInitialized();
    await Get.putAsync(() => SharedPreferecesService().init());
    initServices();
    return runApp(App());
  };

  if (kReleaseMode) {
    SentryFlutter.init((options) {
      options.dsn = Config.SENTRY_DSN;
      options.environment = !kReleaseMode ? 'debug' : 'release';
    }, appRunner: () => run());
  } else {
    run();
  }
}
