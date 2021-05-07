import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'utils/screen.dart';

import 'app/data/services/app_service.dart';
import 'app/data/services/connectivity_service.dart';
import 'app/data/services/db_service.dart';
import 'app/data/services/preferences_service.dart';
import 'app/data/services/task_service.dart';
import 'app/data/services/vibration_service.dart';
import 'app/locales/app_locales.dart';
import 'app/routes/app_middlewares.dart';
import 'app/routes/app_pages.dart';
import 'app/themes/app_theme.dart';
import 'app/themes/dark.dart';
import 'app/themes/light.dart';
import 'config.dart';
import 'generated/locales.g.dart';
import 'utils/index.dart';

// import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  await initServices();
  return runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Config.APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      enableLog: Config.GETX_DEBUG,
      builder: (context, child) {
        ScreenUtil.initialize(context);
        return BotToastInit()(context, child);
      },
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: AppTheme.themeMode,
      routingCallback: AppMiddlewares.routingCallback,
      logWriterCallback: getMaterialLogWriterCallback,
      translationsKeys: AppTranslation.translations,
      // locale:  window.locale, // 将会按照此处指定的语言翻译
      locale: AppLocales.locale,
      fallbackLocale: Locale('zh', 'CN'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      localizationsDelegates: [
        // RefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
      ],
    );
  }
}

Future initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskService()..init());
  await Get.putAsync(() => ConnectivityService().init());

  await Get.putAsync(() => SharedPreferecesService().init());
  Get.put(DbService());
  await Get.putAsync(() => AppService().init());

  await Get.putAsync(() => VibrationService().init());
}
