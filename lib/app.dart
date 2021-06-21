import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/locales/app_locales.dart';
import 'app/routes/index.dart';
import 'app/themes/index.dart';
import 'config.dart';
import 'generated/locales.g.dart';
import 'utils/index.dart';

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
        SentryNavigatorObserver(),
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: AppTheme.themeMode,
      routingCallback: AppMiddlewares.routingCallback,
      logWriterCallback: getMaterialLogWriterCallback,
      translationsKeys: AppTranslation.translations,
      // locale:  window.locale, // 将会按照此处指定的语言翻译
      locale: AppLocales.locale,
      fallbackLocale: Locale('zh'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      localizationsDelegates: [
        // RefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // 美国英语
        const Locale('zh'), // 中文简体
      ],
    );
  }
}
