import 'package:logger/logger.dart';

class Config {
  static const APP_NAME = 'Pecker Flutter';

  static const LOG_LEVEL = Level.debug;

  static const STORAGE_DEBUG = true;

  static const GETX_DEBUG = true;

  static const SENTRY_DSN = 'your SENTRY_DSN';

  static const API_HOST = 'API_HOST';
  static const WS_HOST = 'WS_HOST';
  static const API_HOST_TEST = 'API_HOST_TEST';
  static const WS_HOST_TEST = 'WS_HOST_TEST';
}
