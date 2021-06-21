import 'dart:ui';

import '../data/services/preferences_service.dart';

class AppLocales {
  static Locale get locale => S().languageCode.isEmpty
      ? window.locale
      : S().languageCode == 'en'
          ? Locale('en')
          : Locale('zh');
}
