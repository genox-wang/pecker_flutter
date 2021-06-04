import 'package:logger/logger.dart';

import '../config.dart';

// 日志输出，带方法堆栈
final log = Logger(
  printer: PrettyPrinter(
    printEmojis: false,
    // printTime: true,
  ),
  level: Config.LOG_LEVEL,
);

// 日志工具，不带方法堆栈
final sLog = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    printEmojis: false,
    // printTime: true,
  ),
  level: Config.LOG_LEVEL,
);

// GETX 相关的日志回调
final Function(String, {bool isError}) getMaterialLogWriterCallback =
    (String text, {bool isError = false}) {
  isError ? sLog.e('GETX $text') : sLog.v('GETX $text');
};

// Get.config(

// );
