import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../utils/log.dart';
import '../data/services/index.dart';
import 'index.dart';

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

  static String _curRoute = '';
  static String get oldRoute => _curRoute;

  static _checkRouteChange(String newRoute) {
    // 空路由不算
    if (newRoute == '') {
      return;
    }
    if (_curRoute == newRoute) {
      return;
    }
    if (_curRoute.isNotEmpty) {
      T().pageEnd(_curRoute);
    }
    if (newRoute != Routes.SPLASH) T().pageStart(newRoute);
    sLog.d('route changed: $_curRoute => $newRoute');

    _routeChanged(_curRoute, newRoute);

    _curRoute = newRoute;
  }

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
