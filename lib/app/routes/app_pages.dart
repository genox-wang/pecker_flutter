import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/web_view/bindings/web_view_binding.dart';
import '../modules/web_view/views/web_view_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.WEB_VIEW,
      page: () => WebViewView(),
      binding: WebViewBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
