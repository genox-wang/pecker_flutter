import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/locales.g.dart';
import '../../../../utils/index.dart';
import '../../../data/services/index.dart';

class LocalesSampleController extends GetxController {
  final _languageCode = ''.obs;
  String get languageCode => this._languageCode.value;
  set languageCode(String value) => this._languageCode.value = value;

  @override
  void onInit() {
    languageCode = S().languageCode;
    super.onInit();
  }

  void onLocaleClicked() {
    MyUI.showSelectionBottomSheet(
      selections: [
        LocaleKeys.locales_zh.tr,
        LocaleKeys.locales_en.tr,
        LocaleKeys.locales_system.tr,
      ],
    ).then((value) {
      if (value == 0) {
        updateLocale(Locale('zh'));
      } else if (value == 1) {
        updateLocale(Locale('en'));
      } else if (value == 2) {
        updateLocale(null);
      }
    });
  }

  void updateLocale(Locale? locale) {
    Get.updateLocale(locale ?? window.locale);
    if (locale != null) {
      S().languageCode = Get.locale!.languageCode;
    } else {
      S().languageCode = '';
    }
  }
}
