import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../utils/log.dart';

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

  static String _oldRoute = '';
  static String get oldRoute => _oldRoute;

  static _checkRouteChange(String newRoute) {
    // 空路由不算
    if (newRoute == '') {
      return;
    }
    if (_oldRoute == newRoute) {
      return;
    }
    sLog.d('route changed: $_oldRoute => $newRoute');
    _routeChanged(_oldRoute, newRoute);

    _oldRoute = newRoute;
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
