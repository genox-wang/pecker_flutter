import 'package:flutter/material.dart';

import '../data/services/preferences_service.dart';

/// 应用主题，默认系统主题
class AppTheme {
  static ThemeMode get themeMode => S().appThemeMode == AppThemeMode.system
      ? ThemeMode.system
      : S().appThemeMode == AppThemeMode.dark
          ? ThemeMode.dark
          : ThemeMode.light;
}

enum AppThemeMode {
  system,
  dark,
  light,
}
