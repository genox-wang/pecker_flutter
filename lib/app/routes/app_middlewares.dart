import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../utils/log.dart';
import '../data/services/index.dart';
import 'index.dart';

/// 全局中间件
class AppMiddlewares {
  static routingCallback(Routing? routing) {
    sLog.v('''
AppMiddleware
current: ${routing?.current}
routeName:${routing?.route?.settings.name} 
isBottomSheet: ${routing?.isBottomSheet} 
isDialog: ${routing?.isDialog}
isBack: ${routing?.isBack}''');
    _checkRouteChange('${routing?.route?.settings.name}');
  }

  /// 当前的路由名
  static String _curRoute = '';

  static String get curRoute => _curRoute;

  static _checkRouteChange(String newRoute) {
    // 空路由不算
    if (newRoute == '') {
      return;
    }
    if (_curRoute == newRoute) {
      return;
    }

    /// 如果接入类似友盟的统计插件，根据路由会自动统计页面生命周期
    if (_curRoute.isNotEmpty) {
      T().pageEnd(_curRoute);
    }
    if (newRoute != Routes.SPLASH) T().pageStart(newRoute);
    sLog.d('route changed: $_curRoute => $newRoute');

    _routeChanged(_curRoute, newRoute);

    _curRoute = newRoute;
  }

  /// 路由成功切换，在这里可以根据老旧路由全局触发逻辑
  static _routeChanged(String oldRoute, String newRoute) {
    // if (newRoute == Routes.HOME && oldRoute == Routes.GAME) {
    //   _try(() => Get.find<HomeController>().onBackFromGame());
    // }
  }

  // static _try(Function() callback) {
  //   try {
  //     callback.call();
  //   } catch (e) {}
  // }
}
