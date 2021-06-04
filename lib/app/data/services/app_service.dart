import 'dart:io';

import 'package:flutter/services.dart';

import 'package:device_info/device_info.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:unique_ids/unique_ids.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/index.dart';
import 'index.dart';

// import 'package:flutter_user_agentx/flutter_user_agent.dart';

/// 应用相关服务
class AppService extends GetxService {
  static AppService get to => Get.find();

  late String tempDir;
  late String appDocDir;

  int? buildNumber;
  String? version;
  late String channel;
  late String? webviewUserAgent;

  late String packageName;

  String? deviceMode;

  @override
  void onInit() {
    AppChannel.init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.onInit();
  }

  @override
  void onClose() {
    AppChannel.dispose();
    super.onClose();
  }

  Future<AppService> init() async {
    sLog.e("AppService init");
    // 获取本地文件系统路劲
    await initDirs();
    // 获取 imei 或 idfa
    await loadImeiOrIdfa();
    // 获取包信息
    await loadPackageInfo();
    // 获取 UA
    await loadUserAgent();
    // 获取设备信息
    await loadDeviceInfo();
    return this;
  }

  Future initDirs() async {
    try {
      tempDir = (await getTemporaryDirectory()).path;
      appDocDir = (await getApplicationDocumentsDirectory()).path;
    } catch (e, _) {
      sLog.e("get dir error: ", e);
      // await Sentry.captureException(
      //   e,
      //   stackTrace: s,
      // );
    }

    sLog.d("tempDir $tempDir");
    sLog.d("appDocDir $appDocDir");
  }

  Future loadImeiOrIdfa() async {
    if (S().imeiOrIdfa.isEmpty) {
      try {
        if (Platform.isIOS) {
          await AppChannel.requestIDFA();
        }

        S().imeiOrIdfa = await UniqueIds.adId ?? '';
        if (S().imeiOrIdfa.isEmpty ||
            S().imeiOrIdfa == '00000000-0000-0000-0000-000000000000') {
          S().imeiOrIdfa = Uuid().v4();
        }
      } catch (e, _) {
        sLog.e("get imeiOrIdfa error:", e);
      }
    }

    sLog.d("imeiOrIdfa ${S().imeiOrIdfa}");
  }

  Future loadPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      buildNumber = int.parse(packageInfo.buildNumber);
      version = packageInfo.version;
      packageName = packageInfo.packageName;
    } catch (e, _) {
      sLog.e("get packageInfo error:", e);
    }
  }

  Future loadUserAgent() async {
    await FkUserAgent.init();
    webviewUserAgent = FkUserAgent.userAgent;
    sLog.d("webviewUserAgent $webviewUserAgent");
  }

  Future loadDeviceInfo() async {
    if (S().deviceMode.isNotEmpty) {
      return;
    }
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      S().deviceMode = androidInfo.device;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      S().deviceMode = iosInfo.model;
    }
  }
}
