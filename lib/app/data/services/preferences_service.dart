import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/log.dart';
import '../../themes/app_theme.dart';

final S = () => Get.find<SharedPreferecesService>();

class SharedPreferecesService extends GetxService {
  late SharedPreferences _prefs;
  final List<VoidCallback> listenKeyDisposers = [];

  Future<SharedPreferecesService> init() async {
    _prefs = await SharedPreferences.getInstance();
    sLog.e("SharedPreferences init()");
    return this;
  }

  @override
  void onInit() {
    sLog.e("SharedPreferences onInit");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String get token => _prefs.getString('_token') ?? '';
  set token(String value) => _prefs.setString('_token', value);

  String get imeiOrIdfa => _prefs.getString('idfaOrImei') ?? '';
  set imeiOrIdfa(String value) => _prefs.setString('idfaOrImei', value);

  String get deviceMode => _prefs.getString('deviceMode') ?? '';
  set deviceMode(String value) => _prefs.setString('deviceMode', value);

  String get languageCode => _prefs.getString('languageCode') ?? 'zh';
  set languageCode(String value) => _prefs.setString('languageCode', value);

  AppThemeMode get appThemeMode =>
      AppThemeMode.values[_prefs.getInt('appThemeMode') ?? 0];
  set appThemeMode(AppThemeMode value) =>
      _prefs.setInt('appThemeMode', value.index);
}
