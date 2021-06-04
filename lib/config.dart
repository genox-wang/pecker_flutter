import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Config {
  /// 应用名
  static const APP_NAME = 'Pecker Flutter';
  /// 日志登记
  static const LOG_LEVEL = Level.debug;
  /// 是否输出 getx 日志
  static const GETX_DEBUG = true;
  // TODO 你的 Sentry Dsn
  static const SENTRY_DSN = 'your SENTRY_DSN';
  // TODO http 请求 host
  static const API_HOST = kReleaseMode
      ? 'API_HOST'
      : 'API_HOST_TEST';
  // TODO ws 请求 host
  static const WS_HOST = kReleaseMode
      ? 'WS_HOST'
      : 'WS_HOST_TEST';
}
