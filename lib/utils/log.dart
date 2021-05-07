import 'package:logger/logger.dart';

import '../config.dart';

final log = Logger(
  printer: PrettyPrinter(
    printEmojis: false,
    // printTime: true,
  ),
  level: Config.LOG_LEVEL,
);

final sLog = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    // printTime: true,
  ),
  level: Config.LOG_LEVEL,
);

final Function(String, {bool isError}) getMaterialLogWriterCallback =
    (String text, {bool isError = false}) {
  isError ? sLog.e('GETX $text') : sLog.v('GETX $text');
};

// Get.config(

// );
